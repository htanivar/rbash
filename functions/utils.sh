#!/bin/bash
# utils.sh - utils utility functions for bash scripts

# =============================================================================
# UTILITY FUNCTIONS
# =============================================================================

# Create directory with proper ownership
create_directory() {
    local dir_path="$1"
    local owner="${2:-$(get_current_user)}"
    local group="${3:-$owner}"
    local permissions="${4:-755}"

    mkdir -p "$dir_path" || error_exit "Failed to create directory: $dir_path"

    if [ "$EUID" -eq 0 ]; then
        chown "$owner:$group" "$dir_path" || warn "Failed to set ownership for: $dir_path"
        chmod "$permissions" "$dir_path" || warn "Failed to set permissions for: $dir_path"
    fi

    log_debug "Directory created: $dir_path (owner: $owner:$group, perms: $permissions)"
}

# Backup file with timestamp
backup_file() {
    local file_path="$1"
    local backup_dir="${2:-$(dirname "$file_path")}"
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local backup_path="$backup_dir/$(basename "$file_path").backup.$timestamp"

    if [ -f "$file_path" ]; then
        cp "$file_path" "$backup_path" || error_exit "Failed to backup file: $file_path"
        log_info "File backed up: $file_path -> $backup_path"
        echo "$backup_path"
    else
        warn "File not found for backup: $file_path"
        return 1
    fi
}

# Generate random string
generate_random_string() {
    local length="${1:-16}"
    local charset="${2:-A-Za-z0-9}"

    tr -dc "$charset" < /dev/urandom | head -c "$length"
}

# Check if port is available
check_port() {
    local port="$1"
    local host="${2:-127.0.0.1}"

    if command -v nc &> /dev/null; then
        nc -z "$host" "$port" 2>/dev/null && return 1 || return 0
    elif command -v ss &> /dev/null; then
        ss -tuln | grep -q ":$port " && return 1 || return 0
    else
        warn "Cannot check port availability - neither nc nor ss available"
        return 0
    fi
}
