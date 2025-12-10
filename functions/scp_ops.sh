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
