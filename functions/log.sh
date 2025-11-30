#!/bin/bash
# core_utils.sh - Core utility functions for bash scripts

# Initialize logging with optional custom log file
init_logging() {
    local script_name="${1:-$(basename "$0")}"
    local log_dir="${2:-$DEFAULT_LOG_DIR}"
    local timestamp=$(date +%Y%m%d_%H%M%S)

    DEFAULT_LOG_FILE="${log_dir}/${script_name%.sh}_${timestamp}.log"

    # Create log directory if it doesn't exist
    mkdir -p "$log_dir" 2>/dev/null || {
        # Fallback to /tmp if we can't create in the preferred location
        DEFAULT_LOG_FILE="/tmp/${script_name%.sh}_${timestamp}.log"
    }

    # Create log file and set permissions
    : > "$DEFAULT_LOG_FILE" || {
        echo "Unable to create log file at $DEFAULT_LOG_FILE" >&2
        exit 1
    }

    log "Logging initialized - Log file: $DEFAULT_LOG_FILE"
}

# Log function with timestamp
log() {
    local message="$1"
    local level="${2:-INFO}"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local log_entry="[$timestamp] [$level] $message"

    # Output to both console and log file
    echo "$log_entry" >&2
    if [ -n "$DEFAULT_LOG_FILE" ]; then
        echo "$log_entry" >> "$DEFAULT_LOG_FILE"
    fi
}

# Specialized logging functions
log_info() {
    log "$1" "INFO"
}

log_warn() {
    log "$1" "WARN"
}

log_error() {
    log "$1" "ERROR"
}

log_debug() {
    if [ "${DEBUG:-0}" = "1" ]; then
        log "$1" "DEBUG"
    fi
}

log_step() {
    local step="$1"
    local message="$2"
    log "[$step] $message" "STEP"
}

# Log command execution
log_command() {
    local command="$1"
    local log_file="${2:-command_log.txt}"
    echo "$command" >> "$log_file"
    log "Command logged to $log_file: $command" "CMD"
}
