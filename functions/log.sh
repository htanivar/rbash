#!/bin/bash
# core_utils.sh - Core utility functions for bash scripts
# Source this file at the beginning of your scripts: source "$(dirname "$0")/helpers/core_utils.sh"

# Source the configuration using PROJECT_ROOT_DIR
if [ -n "$PROJECT_ROOT_DIR" ]; then
    source "$PROJECT_ROOT_DIR/config/config.sh"
else
    echo "PROJECT_ROOT_DIR is not set. Please set it before sourcing log.sh" >&2
    exit 1
fi

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
