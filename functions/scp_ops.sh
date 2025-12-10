#!/bin/bash
# scp_ops.sh - SCP operations utility functions for bash scripts

# =============================================================================
# SCP OPERATIONS
# =============================================================================

# Copy file from remote host using scp
copy_remote_file() {
    local remote_user="$1"
    local remote_host="$2"
    local remote_path="$3"
    local local_path="$4"
    local scp_options="${5:-}"

    log_step "SCP" "Copying file from $remote_user@$remote_host:$remote_path to $local_path"

    # Check if scp command exists
    require_command "scp"

    # Build the scp command
    local scp_cmd="scp"
    if [ -n "$scp_options" ]; then
        scp_cmd="$scp_cmd $scp_options"
    fi
    scp_cmd="$scp_cmd $remote_user@$remote_host:$remote_path $local_path"

    log_info "Executing: $scp_cmd"
    
    # Execute the scp command
    if eval "$scp_cmd"; then
        log_info "Successfully copied file from remote"
        return 0
    else
        log_error "Failed to copy file from remote"
        return 1
    fi
}

# Copy file to remote host using scp
copy_to_remote() {
    local local_path="$1"
    local remote_user="$2"
    local remote_host="$3"
    local remote_path="$4"
    local scp_options="${5:-}"

    log_step "SCP" "Copying file $local_path to $remote_user@$remote_host:$remote_path"

    # Check if scp command exists
    require_command "scp"

    # Check if local file exists
    if [ ! -f "$local_path" ] && [ ! -d "$local_path" ]; then
        log_error "Local path does not exist: $local_path"
        return 1
    fi

    # Build the scp command
    local scp_cmd="scp"
    if [ -n "$scp_options" ]; then
        scp_cmd="$scp_cmd $scp_options"
    fi
    scp_cmd="$scp_cmd $local_path $remote_user@$remote_host:$remote_path"

    log_info "Executing: $scp_cmd"
    
    # Execute the scp command
    if eval "$scp_cmd"; then
        log_info "Successfully copied file to remote"
        return 0
    else
        log_error "Failed to copy file to remote"
        return 1
    fi
}

# Copy directory recursively from remote host
copy_remote_directory() {
    local remote_user="$1"
    local remote_host="$2"
    local remote_path="$3"
    local local_path="$4"
    local scp_options="${5:-}"

    log_step "SCP" "Copying directory from $remote_user@$remote_host:$remote_path to $local_path"

    # Check if scp command exists
    require_command "scp"

    # Add recursive option
    local full_scp_options="-r"
    if [ -n "$scp_options" ]; then
        full_scp_options="$full_scp_options $scp_options"
    fi

    # Build the scp command
    local scp_cmd="scp $full_scp_options $remote_user@$remote_host:$remote_path $local_path"

    log_info "Executing: $scp_cmd"
    
    # Execute the scp command
    if eval "$scp_cmd"; then
        log_info "Successfully copied directory from remote"
        return 0
    else
        log_error "Failed to copy directory from remote"
        return 1
    fi
}

# Copy directory recursively to remote host
copy_directory_to_remote() {
    local local_path="$1"
    local remote_user="$2"
    local remote_host="$3"
    local remote_path="$4"
    local scp_options="${5:-}"

    log_step "SCP" "Copying directory $local_path to $remote_user@$remote_host:$remote_path"

    # Check if scp command exists
    require_command "scp"

    # Check if local directory exists
    if [ ! -d "$local_path" ]; then
        log_error "Local directory does not exist: $local_path"
        return 1
    fi

    # Add recursive option
    local full_scp_options="-r"
    if [ -n "$scp_options" ]; then
        full_scp_options="$full_scp_options $scp_options"
    fi

    # Build the scp command
    local scp_cmd="scp $full_scp_options $local_path $remote_user@$remote_host:$remote_path"

    log_info "Executing: $scp_cmd"
    
    # Execute the scp command
    if eval "$scp_cmd"; then
        log_info "Successfully copied directory to remote"
        return 0
    else
        log_error "Failed to copy directory to remote"
        return 1
    fi
}

# Test SSH connection to remote host
test_ssh_connection() {
    local remote_user="$1"
    local remote_host="$2"
    local ssh_options="${3:-}"

    log_step "SSH" "Testing SSH connection to $remote_user@$remote_host"

    # Check if ssh command exists
    require_command "ssh"

    # Build the ssh command
    local ssh_cmd="ssh"
    if [ -n "$ssh_options" ]; then
        ssh_cmd="$ssh_cmd $ssh_options"
    fi
    ssh_cmd="$ssh_cmd $remote_user@$remote_host 'echo \"SSH connection successful\"'"

    log_info "Testing connection with: $ssh_cmd"
    
    # Execute the ssh command
    if eval "$ssh_cmd"; then
        log_info "SSH connection test successful"
        return 0
    else
        log_error "SSH connection test failed"
        return 1
    fi
}

# Create directory on remote host
create_remote_directory() {
    local remote_user="$1"
    local remote_host="$2"
    local remote_path="$3"
    local ssh_options="${4:-}"
    local permissions="${5:-}"
    local owner="${6:-}"
    local group="${7:-}"

    log_step "SSH" "Creating directory on $remote_user@$remote_host:$remote_path"

    # Check if ssh command exists
    require_command "ssh"

    # Build the base ssh command
    local ssh_cmd="ssh"
    if [ -n "$ssh_options" ]; then
        ssh_cmd="$ssh_cmd $ssh_options"
    fi
    ssh_cmd="$ssh_cmd $remote_user@$remote_host"

    # Create the directory
    local create_cmd="mkdir -p \"$remote_path\""
    log_info "Executing: $ssh_cmd '$create_cmd'"
    
    if eval "$ssh_cmd '$create_cmd'"; then
        log_info "Directory created successfully on remote host"
    else
        log_error "Failed to create directory on remote host"
        return 1
    fi

    # Set permissions if specified
    if [ -n "$permissions" ]; then
        local chmod_cmd="chmod $permissions \"$remote_path\""
        log_info "Setting permissions: $ssh_cmd '$chmod_cmd'"
        
        if eval "$ssh_cmd '$chmod_cmd'"; then
            log_info "Permissions set to $permissions on remote directory"
        else
            log_warn "Failed to set permissions on remote directory"
        fi
    fi

    # Set ownership if specified (requires root or sudo access)
    if [ -n "$owner" ] && [ -n "$group" ]; then
        local chown_cmd="chown $owner:$group \"$remote_path\""
        log_info "Setting ownership: $ssh_cmd '$chown_cmd'"
        
        if eval "$ssh_cmd '$chown_cmd'"; then
            log_info "Ownership set to $owner:$group on remote directory"
        else
            log_warn "Failed to set ownership on remote directory (may need sudo)"
        fi
    elif [ -n "$owner" ]; then
        local chown_cmd="chown $owner \"$remote_path\""
        log_info "Setting owner: $ssh_cmd '$chown_cmd'"
        
        if eval "$ssh_cmd '$chown_cmd'"; then
            log_info "Owner set to $owner on remote directory"
        else
            log_warn "Failed to set owner on remote directory (may need sudo)"
        fi
    fi

    return 0
}

# Create multiple directories on remote host
create_remote_directories() {
    local remote_user="$1"
    local remote_host="$2"
    local ssh_options="${3:-}"
    shift 3
    local directories=("$@")

    log_step "SSH" "Creating multiple directories on $remote_user@$remote_host"

    for dir in "${directories[@]}"; do
        if ! create_remote_directory "$remote_user" "$remote_host" "$dir" "$ssh_options"; then
            log_error "Failed to create directory: $dir"
            return 1
        fi
    done

    log_info "All directories created successfully on remote host"
    return 0
}
