#!/bin/bash

# --- Configuration ---
LOG_FILE="/var/log/timesync_script.log"
DATE_THRESHOLD_SECONDS=1800 # 30 minutes (1800 seconds) difference is considered severe drift
NTP_SERVER="pool.ntp.org"

# Function to log messages
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | sudo tee -a "$LOG_FILE" >/dev/null
    echo "$1"
}

log_message "--- Starting Time Synchronization Check ---"

# 1. Check if timedatectl exists (for modern Linux systems)
if ! command -v timedatectl &> /dev/null; then
    log_message "WARNING: timedatectl command not found. Falling back to ntpdate."
    if command -v ntpdate &> /dev/null; then
        log_message "Attempting quick sync with ntpdate..."
        sudo ntpdate -u "$NTP_SERVER"
        log_message "Time synchronization attempt complete."
        exit 0
    else
        log_message "ERROR: Neither timedatectl nor ntpdate found. Cannot proceed."
        log_message "Please install ntpdate: sudo apt install ntpdate"
        exit 1
    fi
fi

# 2. Check current synchronization status
SYNC_STATUS=$(timedatectl status | grep 'System clock synchronized:' | awk '{print $NF}')
NTP_STATUS=$(timedatectl status | grep 'NTP service:' | awk '{print $NF}')

log_message "Current status: System synchronized: $SYNC_STATUS, NTP service: $NTP_STATUS"

# 3. Check for severe time drift (useful after snapshot restore)
log_message "Checking for severe time drift..."

# Use ntpdate to quickly check the offset without applying it
TIME_OFFSET_LINE=$(sudo ntpdate -q "$NTP_SERVER" 2>&1 | grep 'offset' | head -n 1)

if [ -z "$TIME_OFFSET_LINE" ]; then
    log_message "WARNING: Could not determine time offset. Assuming NTP service is responsible."
else
    # Extract the offset value (e.g., -1036800.000000)
    # The output format is often: "10 Dec 16:00:00 ntpdate[1234]: adjust time server 12.34.56.78 offset -1036800.000000 sec"
    TIME_OFFSET_SECONDS=$(echo "$TIME_OFFSET_LINE" | awk '{print $NF}' | cut -d' ' -f1 | tr -d 'sec' | sed 's/[^0-9.-]//g')
    TIME_OFFSET_ABS=$(echo "$TIME_OFFSET_SECONDS" | awk '{print ($1 < 0) ? -$1 : $1}')

    log_message "Current time offset from $NTP_SERVER: ${TIME_OFFSET_SECONDS} seconds."

    # If the absolute offset is greater than the defined threshold, we need a hard sync
    if (( $(echo "$TIME_OFFSET_ABS > $DATE_THRESHOLD_SECONDS" | bc -l) )); then
        log_message "SEVERE DRIFT DETECTED (${TIME_OFFSET_ABS}s > ${DATE_THRESHOLD_SECONDS}s). Forcing time jump."

        # Stop NTP service to allow large time change
        sudo timedatectl set-ntp false
        sudo systemctl stop systemd-timesyncd

        # Use ntpdate (best for time jumps)
        if command -v ntpdate &> /dev/null; then
            log_message "Using ntpdate to set clock."
            sudo ntpdate -u "$NTP_SERVER"
        else
            # If ntpdate is not available, try a hard set using timesyncd which may fail
            log_message "WARNING: ntpdate not installed. Trying to start systemd-timesyncd for hard jump."
            sudo systemctl start systemd-timesyncd
        fi

        # Restart normal synchronization
        sudo timedatectl set-ntp true
        log_message "Forced sync complete. NTP service reactivated."
    else
        log_message "Time drift is within tolerance. Relying on background NTP daemon."
        sudo timedatectl set-ntp true
    fi
fi

log_message "--- Time Synchronization Check Finished ---"