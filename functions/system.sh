#!/bin/bash
# system.sh - system utility functions for bash scripts

# =============================================================================
# SYSTEM INFORMATION FUNCTIONS
# =============================================================================

# Get current user (works with sudo)
get_current_user() {
    local user
    user=$(logname 2>/dev/null || whoami)

    if [ "$user" = "root" ] || [ -z "$user" ]; then
        user="${SUDO_USER:-$(ps -o user= -p "$PPID" | awk '{print $1}')}"
    fi

    if [ "$user" = "root" ] || [ -z "$user" ]; then
        error_exit "Cannot determine the non-root user"
    fi

    echo "$user"
}

# Get distribution information
get_distribution() {
    if command -v lsb_release &> /dev/null; then
        lsb_release -si | tr '[:upper:]' '[:lower:]'
    elif [ -f /etc/os-release ]; then
        . /etc/os-release
        echo "$ID"
    else
        echo "unknown"
    fi
}

# Check if distribution is supported
check_distribution() {
    local supported_distros="$1"  # Space-separated list
    local current_distro
    current_distro=$(get_distribution)

    if [[ " $supported_distros " =~ " $current_distro " ]]; then
        log_debug "Distribution supported: $current_distro"
        return 0
    else
        error_exit "Unsupported distribution: $current_distro. Supported: $supported_distros"
    fi
}
