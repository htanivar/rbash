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

# Add directory to PATH
add_to_path() {
    local directory="$1"
    local user="${2:-$(get_current_user)}"
    local profile_file="${3:-$HOME/.bashrc}"

    log_step "PATH" "Adding directory to PATH: $directory"

    # Check if directory exists
    if [ ! -d "$directory" ]; then
        warn "Directory does not exist: $directory"
        return 1
    fi

    # Check if already in PATH
    if [[ ":$PATH:" == *":$directory:"* ]]; then
        log_debug "Directory already in PATH: $directory"
        return 0
    fi

    # Add to PATH in current session
    export PATH="$directory:$PATH"

    # Add to profile file for persistence
    echo "export PATH=\"$directory:\$PATH\"" >> "$profile_file"

    log_info "Directory added to PATH: $directory"
}

# Create symbolic link in PATH
create_path_link() {
    local target="$1"
    local link_name="$2"
    local bin_dir="${3:-$HOME/.local/bin}"

    log_step "LINK" "Creating symbolic link: $link_name -> $target"

    # Ensure target exists
    require_file "$target"

    # Create bin directory if it doesn't exist
    create_directory "$bin_dir"
    log_debug "Ensured bin directory exists: $bin_dir"

    # Use just the basename for the link
    local link_basename=$(basename "$link_name")
    local link_path="$bin_dir/$link_basename"

    log_debug "Link path will be: $link_path"

    # Remove existing link if it exists
    if [ -L "$link_path" ]; then
        rm "$link_path"
        log_debug "Existing symbolic link removed: $link_path"
    elif [ -e "$link_path" ]; then
        error_exit "A regular file exists at $link_path. Please remove it manually."
    fi

    # Create new symbolic link
    ln -s "$target" "$link_path" || error_exit "Failed to create symbolic link: $link_path -> $target"

    # Make sure bin directory is in PATH
    add_to_path "$bin_dir"

    log_info "Symbolic link created: $link_basename -> $target"
}
