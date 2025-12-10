#!/bin/bash

# Source the main loader instead of individual files
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)/core-loader.sh"

echo "=== Copying user rc files to local ==="
echo

# Array of rc files to copy
declare -a RC_FILES=(
    ".bashrc"
    ".zshrc"
    ".commonrc"
)

# Configuration
REMOTE_USER="${REMOTE_USER:-}"
REMOTE_HOST="${REMOTE_HOST:-}"
REMOTE_SRC_DIR="${REMOTE_SRC_DIR:-}"
LOCAL_DEST_DIR="$HOME"
SCP_OPTIONS="${SCP_OPTIONS:-}"

prompt_input "Enter Remote username: " "REMOTE_USER" "$USER"
require_var "REMOTE_USER"
prompt_input "Enter Remote Host: " "REMOTE_HOST" "localhost"
require_var "REMOTE_HOST"



log_step "COPY-RC" "Starting to copy rc files"

# Determine if we're copying from remote or local
if [ -n "$REMOTE_USER" ] && [ -n "$REMOTE_HOST" ]; then
    COPY_FROM_REMOTE=true
    log_info "Copying from remote host: $REMOTE_USER@$REMOTE_HOST"
    
    # Test SSH connection first
    log_step "COPY-RC" "Testing SSH connection to remote host"
    if ! test_ssh_connection "$REMOTE_USER" "$REMOTE_HOST" "$SCP_OPTIONS"; then
        log_error "SSH connection test failed. Cannot proceed with remote copy."
        error_exit "Failed to establish SSH connection to $REMOTE_USER@$REMOTE_HOST"
    fi
    
    # Set remote source directory to the remote user's home directory
    # We'll try to get it from SSH, default to ~ if we can't
    if [ -z "$REMOTE_SRC_DIR" ]; then
        log_info "Determining remote user's home directory..."
        # Try to get home directory via SSH
        REMOTE_HOME_CMD="ssh $SCP_OPTIONS $REMOTE_USER@$REMOTE_HOST 'echo \$HOME' 2>/dev/null"
        REMOTE_SRC_DIR=$(eval "$REMOTE_HOME_CMD" || echo "")
        if [ -z "$REMOTE_SRC_DIR" ]; then
            # If we can't get it via SSH, default to ~
            REMOTE_SRC_DIR="~"
            log_warn "Could not determine remote home directory, using: $REMOTE_SRC_DIR"
        else
            log_info "Remote home directory: $REMOTE_SRC_DIR"
        fi
    else
        log_info "Using custom remote source directory: $REMOTE_SRC_DIR"
    fi
else
    COPY_FROM_REMOTE=false
    log_info "Copying from local system"
    
    # Set default local source directory
    if [ -z "$REMOTE_SRC_DIR" ]; then
        REMOTE_SRC_DIR="/etc/skel"
    fi
    
    # Check if local source directory exists
    if [ ! -d "$REMOTE_SRC_DIR" ]; then
        log_warn "Local source directory does not exist: $REMOTE_SRC_DIR"
        log_info "Trying alternative locations..."
        
        # Try common alternative locations
        if [ -d "/etc/skel" ]; then
            REMOTE_SRC_DIR="/etc/skel"
            log_info "Using /etc/skel as source directory"
        elif [ -d "/usr/local/etc/skel" ]; then
            REMOTE_SRC_DIR="/usr/local/etc/skel"
            log_info "Using /usr/local/etc/skel as source directory"
        else
            error_exit "Could not find a valid source directory"
        fi
    fi
    log_info "Local source directory: $REMOTE_SRC_DIR"
fi

log_info "Local destination directory: $LOCAL_DEST_DIR"

# Copy each rc file
for rc_file in "${RC_FILES[@]}"; do
    remote_file="$REMOTE_SRC_DIR/$rc_file"
    local_file="$LOCAL_DEST_DIR/$rc_file"
    
    log_step "COPY-RC" "Processing $rc_file"
    
    # Check if local file already exists
    if [ -f "$local_file" ]; then
        log_info "Local file already exists: $local_file"
        
        # Create a backup
        backup_file "$local_file" "$LOCAL_DEST_DIR"
        if [ $? -eq 0 ]; then
            log_info "Backup created for existing file"
        fi
        
        # Ask user if they want to overwrite
        if confirm_action "Overwrite $local_file?" "n"; then
            # Remove existing file before copying
            rm -f "$local_file"
        else
            log_info "Skipping $rc_file (user chose not to overwrite)"
            continue
        fi
    fi
    
    # Copy the file
    if [ "$COPY_FROM_REMOTE" = true ]; then
        # Copy from remote using scp
        log_info "Copying from remote: $REMOTE_USER@$REMOTE_HOST:$remote_file"
        if copy_remote_file "$REMOTE_USER" "$REMOTE_HOST" "$remote_file" "$local_file" "$SCP_OPTIONS"; then
            log_info "Successfully copied from remote: $rc_file"
        else
            log_error "Failed to copy from remote: $rc_file"
        fi
    else
        # Copy from local
        if [ -f "$remote_file" ]; then
            cp "$remote_file" "$local_file"
            if [ $? -eq 0 ]; then
                log_info "Successfully copied: $rc_file"
            else
                log_error "Failed to copy: $rc_file"
            fi
        else
            log_warn "Source file not found: $remote_file"
        fi
    fi
done

log_step "COPY-RC" "Finished copying rc files"
echo
echo "Summary:"
if [ "$COPY_FROM_REMOTE" = true ]; then
    echo "Remote source: $REMOTE_USER@$REMOTE_HOST:$REMOTE_SRC_DIR"
    echo "Note: Remote source directory is the remote user's home directory"
else
    echo "Local source: $REMOTE_SRC_DIR"
fi
echo "Local destination: $LOCAL_DEST_DIR"
echo "Files processed: ${RC_FILES[*]}"
echo
echo "Usage examples:"
echo "  # Copy from local /etc/skel (default)"
echo "  bash scripts/user/copy-rc.sh"
echo
echo "  # Copy from remote host (uses remote user's home directory)"
echo "  REMOTE_USER=user REMOTE_HOST=example.com bash scripts/user/copy-rc.sh"
echo
echo "  # Copy from remote host with custom SCP options"
echo "  REMOTE_USER=user REMOTE_HOST=example.com SCP_OPTIONS=\"-P 2222 -i ~/.ssh/id_rsa\" bash scripts/user/copy-rc.sh"
echo
echo "  # Copy from custom local directory"
echo "  REMOTE_SRC_DIR=/path/to/custom/skel bash scripts/user/copy-rc.sh"
echo
echo "  # Copy from custom remote directory"
echo "  REMOTE_USER=user REMOTE_HOST=example.com REMOTE_SRC_DIR=/custom/path bash scripts/user/copy-rc.sh"

