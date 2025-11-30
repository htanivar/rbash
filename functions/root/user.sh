#!/bin/bash
# user.sh - System and user management helper functions

# =============================================================================
# USER MANAGEMENT
# =============================================================================

# Create user with options
create_user() {
    local username="$1"
    local password="$2"
    local home_dir="${3:-/home/$username}"
    local shell="${4:-/bin/bash}"
    local groups="${5:-}"
    local create_home="${6:-true}"

    must_be_root

    log_step "USER" "Creating user: $username"

    # Check if user already exists
    if id "$username" &>/dev/null; then
        warn "User already exists: $username"
        return 1
    else
        log_debug "User DOES NOT exists: $username"
    fi

    # Build useradd command
    local useradd_cmd="useradd"

    if [ "$create_home" = "true" ]; then
        useradd_cmd="$useradd_cmd -m"
    fi

    useradd_cmd="$useradd_cmd -d $home_dir -s $shell"

    # Add supplementary groups
    if [ -n "$groups" ]; then
        useradd_cmd="$useradd_cmd -G $groups"
    fi

    log_debug "issuing command: $useradd_cmd $username"
    useradd_cmd="$useradd_cmd $username"

    # Create the user
    eval "$useradd_cmd" || error_exit "Failed to create user: $username"

    # Set password if provided
    if [ -n "$password" ]; then
        echo "$username:$password" | chpasswd || error_exit "Failed to set password for user: $username"
        log_debug "Password set for user: $username"
    fi

    log_info "User created successfully: $username"
}

# Create admin user (with sudo access)
create_admin_user() {
    local username="$1"
    local password="$2"
    local home_dir="${3:-/home/$username}"
    local shell="${4:-/bin/bash}"

    # Create user with sudo group
    create_user "$username" "$password" "$home_dir" "$shell" "sudo"

    log_info "Admin user created with sudo access: $username"
}

# Delete user
delete_user() {
    local username="$1"
    local remove_home="${2:-true}"
    local remove_mail="${3:-true}"

    must_be_root

    log_step "USER" "Deleting user: $username"

    # Check if user exists
    if ! id "$username" &>/dev/null; then
        warn "User does not exist: $username"
        return 1
    fi

    # Build userdel command
    local userdel_cmd="userdel"

    if [ "$remove_home" = "true" ]; then
        userdel_cmd="$userdel_cmd -r"
    fi

    if [ "$remove_mail" = "true" ]; then
        userdel_cmd="$userdel_cmd -f"
    fi

    userdel_cmd="$userdel_cmd $username"

    # Delete the user
    eval "$userdel_cmd" || error_exit "Failed to delete user: $username"

    log_info "User deleted: $username"
}

# Add user to group
add_user_to_group() {
    local username="$1"
    local group="$2"

    must_be_root

    log_step "USER" "Adding user $username to group: $group"

    usermod -aG "$group" "$username" || error_exit "Failed to add user $username to group: $group"

    log_info "User $username added to group: $group"
}

# Remove user from group
remove_user_from_group() {
    local username="$1"
    local group="$2"

    must_be_root

    log_step "USER" "Removing user $username from group: $group"

    gpasswd -d "$username" "$group" || warn "Failed to remove user $username from group: $group"

    log_info "User $username removed from group: $group"
}

# Setup SSH key for user
setup_ssh_key() {
    local username="$1"
    local public_key_content="$2"
    local key_file="${3:-authorized_keys}"

    must_be_root

    log_step "SSH" "Setting up SSH key for user: $username"

    local home_dir=$(getent passwd "$username" | cut -d: -f6)
    if [ -z "$home_dir" ]; then
        error_exit "Could not determine home directory for user: $username"
    fi

    local ssh_dir="$home_dir/.ssh"
    local auth_keys_file="$ssh_dir/$key_file"

    # Create .ssh directory
    create_directory "$ssh_dir" "$username" "$username" 700

    # Add public key
    echo "$public_key_content" >> "$auth_keys_file"
    chown "$username:$username" "$auth_keys_file"
    chmod 600 "$auth_keys_file"

    log_info "SSH key setup completed for user: $username"
}

# Generate SSH key pair for user
generate_ssh_key() {
    local username="$1"
    local key_type="${2:-rsa}"
    local key_size="${3:-4096}"
    local comment="${4:-$username@$(hostname)}"

    log_step "SSH" "Generating SSH key pair for user: $username"

    local home_dir
    if [ "$username" = "$(whoami)" ]; then
        home_dir="$HOME"
    else
        home_dir=$(getent passwd "$username" | cut -d: -f6)
    fi

    if [ -z "$home_dir" ]; then
        error_exit "Could not determine home directory for user: $username"
    fi

    local ssh_dir="$home_dir/.ssh"
    local private_key="$ssh_dir/id_$key_type"
    local public_key="$ssh_dir/id_${key_type}.pub"

    # Create .ssh directory
    create_directory "$ssh_dir" "$username" "$username" 700

    # Generate key pair
    ssh-keygen -t "$key_type" -b "$key_size" -f "$private_key" -C "$comment" -N "" \
        || error_exit "Failed to generate SSH key pair for user: $username"

    # Set proper ownership and permissions
    chown "$username:$username" "$private_key" "$public_key"
    chmod 600 "$private_key"
    chmod 644 "$public_key"

    log_info "SSH key pair generated for user: $username"
    log_info "Private key: $private_key"
    log_info "Public key: $public_key"
}
