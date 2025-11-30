#!/bin/bash
# validation.sh - validation utility functions for bash scripts

# =============================================================================
# VALIDATION FUNCTIONS
# =============================================================================
# Strictly require root user (UID 0)
must_be_root() {
    if [ "$EUID" -ne 0 ]; then
        echo "Error: This script must be run as root. Use 'sudo $0' or run as root user." >&2
        exit 1
    fi
}

# Check if script is run as root
require_sudo() {
     if [ "$EUID" -eq 0 ]; then
            log_debug "Already running as root"
            return 0
        fi

        if ! command -v sudo >/dev/null 2>&1; then
            error_exit "sudo is not available on this system"
        fi

        if groups | grep -q -E '\b(sudo|wheel|admin)\b'; then
            log_debug "User has sudo group membership"
            return 0
        fi

        error_exit "User does not have sudo access"
}

# Check if script is NOT run as root
require_non_root() {
    if [ "$EUID" -eq 0 ]; then
        error_exit "This script should not be run as root. Run as a regular user."
    fi
    log_debug "Non-root execution confirmed"
}

# Validate required variables
require_var() {
    local var_name="$1"
    local var_value="${!var_name:-}"
    if [ -z "$var_value" ]; then
        error_exit "Required variable '$var_name' is not set or empty"
    fi
    log_debug "Variable validation passed: $var_name"
}

# Check if command exists
require_command() {
    local command="$1"
    if ! command -v "$command" &> /dev/null; then
        error_exit "Required command '$command' is not available"
    fi
    log_debug "Command availability confirmed: $command"
}

# Check if file exists
require_file() {
    local file_path="$1"
    if [ ! -f "$file_path" ]; then
        error_exit "Required file does not exist: $file_path"
    fi
    log_debug "File existence confirmed: $file_path"
}

# Check if directory exists
require_directory() {
    local dir_path="$1"
    if [ ! -d "$dir_path" ]; then
        error_exit "Required directory does not exist: $dir_path"
    fi
    log_debug "Directory existence confirmed: $dir_path"
}

# Validate file permissions
check_file_permissions() {
    local file_path="$1"
    local required_perms="${2:-r}"  # r, w, x

    case "$required_perms" in
        *r*) [ -r "$file_path" ] || error_exit "File not readable: $file_path" ;;
        *w*) [ -w "$file_path" ] || error_exit "File not writable: $file_path" ;;
        *x*) [ -x "$file_path" ] || error_exit "File not executable: $file_path" ;;
    esac
    log_debug "File permissions validated: $file_path ($required_perms)"
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

