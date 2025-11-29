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

# Generate SSH key pair
generate_ssh_key() {
    local key_path="$1"
    local comment="$2"
    local key_type="${3:-rsa}"
    local key_size="${4:-4096}"

    log_step "SSH" "Generating SSH key pair at: $key_path"

    # Ensure the directory exists
    local key_dir
    key_dir=$(dirname "$key_path")
    create_directory "$key_dir"

    # Generate key pair
    ssh-keygen -t "$key_type" -b "$key_size" -f "$key_path" -C "$comment" -N "" \
        || error_exit "Failed to generate SSH key pair at: $key_path"

    # Set proper permissions
    chmod 600 "$key_path" || warn "Failed to set permissions on private key: $key_path"
    chmod 644 "$key_path.pub" || warn "Failed to set permissions on public key: $key_path.pub"

    log_info "SSH key pair generated"
    log_info "Private key: $key_path"
    log_info "Public key: $key_path.pub"
}


