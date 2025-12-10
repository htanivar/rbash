#!/bin/bash

# --- Configuration ---
LOG_FILE="/var/log/timesync_script.log"
DATE_THRESHOLD_SECONDS=1800 # 30 minutes (1800 seconds) difference is considered severe drift
NTP_SERVER="pool.ntp.org"

# Function to log messages
log_message() {
    # Log to screen and to file (requires sudo for file write)
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | sudo tee -a "$LOG_FILE" >/dev/null
    echo "$1"
}

# Function to check for and install ntpdate
install_ntpdate() {
    if ! command -v ntpdate &> /dev/null; then
        log_message "ntpdate not found. Attempting to install it for hard time sync."

        if command -v apt &> /dev/null; then
            # The DEBIAN_FRONTEND suppresses configuration prompts for unattended installs
            sudo DEBIAN_FRONTEND=noninteractive apt update >/dev/null 2>&1
            if sudo DEBIAN_FRONTEND=noninteractive apt install -y ntpdate >/dev/null 2>&1; then
                log_message "ntpdate installed successfully."

                # --- Crucial delay for network stability after install ---
                log_message "Waiting 10 seconds for network stability..."
                sleep 10
                # --------------------------------------------------------

                return 0 # Success
            else
                log_message "ERROR: Failed to install ntpdate. Check network connection and package sources."
                return 1 # Failure
            fi
        else
            log_message "ERROR: Cannot install ntpdate. System does not use apt."
            return 1 # Failure
        fi
    fi
    return 0 # Already installed
}

log_message "--- Starting Time Synchronization Check ---"

# 1. Check if timedatectl exists (for modern Linux systems)
if ! command -v timedatectl &> /dev/null; then
    log_message "WARNING: timedatectl command not found. Falling back to ntpdate-only mode."

    if ! install_ntpdate; then
        log_message "FATAL ERROR: Could not install ntpdate. Exiting."
        exit 1
    fi

    log_message "Attempting quick sync with ntpdate..."
    sudo ntpdate -u "$NTP_SERVER"
    log_message "Time synchronization attempt complete."
    exit 0
fi

# 2. Check current synchronization status
SYNC_STATUS=$(timedatectl status | grep 'System clock synchronized:' | awk '{print $NF}')
NTP_STATUS=$(timedatectl status | grep 'NTP service:' | awk '{print $NF}')

log_message "Current status: System synchronized: $SYNC_STATUS, NTP service: $NTP_STATUS"

# 3. Check for severe time drift (useful after snapshot restore)
log_message "Checking for severe time drift..."

# Ensure ntpdate is available for offset calculation and hard sync
if ! command -v ntpdate &> /dev/null; then
    install_ntpdate
    if ! command -v ntpdate &> /dev/null; then
        log_message "WARNING: ntpdate is required but could not be installed/found. Skipping severe drift check."
        log_message "--- Time Synchronization Check Finished ---"
        exit 0
    fi
fi

# Use ntpdate to quickly check the offset without applying it.
# We direct output to a variable for manual parsing.
log_message "Running ntpdate query for offset..."
TEMP_NTP_OUTPUT=$(sudo ntpdate -q "$NTP_SERVER" 2>&1)

# Extract the line containing the offset number. This uses a robust pattern match
# for lines starting with a date pattern (e.g., 2025-...)
TIME_OFFSET_LINE=$(echo "$TEMP_NTP_OUTPUT" | grep -E '^[0-9]{4}-[0-9]{2}-[0-9]{2}' | head -n 1)

# Check if we got a valid line
if [ -z "$TIME_OFFSET_LINE" ]; then
    log_message "WARNING: Could not determine time offset from NTP server."
    log_message "Possible network path issue (UDP port 123 blocked) or parsing error. Raw output:"
    echo "$TEMP_NTP_OUTPUT" | log_message
else
    # FIX: Extract the sixth field, which is the offset number (e.g., +1085239.234396)
    TIME_OFFSET_SECONDS=$(echo "$TIME_OFFSET_LINE" | awk '{print $6}' | sed 's/[^0-9.-]//g')
    TIME_OFFSET_ABS=$(echo "$TIME_OFFSET_SECONDS" | awk '{print ($1 < 0) ? -$1 : $1}')

    # Validation check to ensure the output is a valid number
    if ! [[ "$TIME_OFFSET_SECONDS" =~ ^[+-]?[0-9]*\.?[0-9]+$ ]]; then
        log_message "ERROR: Failed to parse numeric offset. Raw offset field: $(echo "$TIME_OFFSET_LINE" | awk '{print $6}')"
        log_message "--- Time Synchronization Check Finished ---"
        exit 1
    fi

    log_message "Current time offset from $NTP_SERVER: ${TIME_OFFSET_SECONDS} seconds."

    # If the absolute offset is greater than the defined threshold, we need a hard sync
    if (( $(echo "$TIME_OFFSET_ABS > $DATE_THRESHOLD_SECONDS" | bc -l) )); then
        log_message "SEVERE DRIFT DETECTED (${TIME_OFFSET_ABS}s > ${DATE_THRESHOLD_SECONDS}s). Forcing time jump."

        # Stop NTP service to allow large time change
        sudo timedatectl set-ntp false
        sudo systemctl stop systemd-timesyncd

        log_message "Using ntpdate to set clock."
        # Perform the hard time jump
        sudo ntpdate -u "$NTP_SERVER"

        # Restart normal synchronization
        sudo timedatectl set-ntp true
        log_message "Forced sync complete. NTP service reactivated."
    else
        log_message "Time drift is within tolerance. Relying on background NTP daemon."
        sudo timedatectl set-ntp true
    fi
fi

log_message "--- Time Synchronization Check Finished ---"