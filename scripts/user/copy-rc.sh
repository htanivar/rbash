#!/bin/bash

# Source the main loader instead of individual files
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)/core-loader.sh"

echo "=== Copying user rc files from remote to local ==="
echo

# Array of rc files to copy from remote to local
declare -a RC_FILES=(
    ".bashrc"
    ".zshrc"
    ".commonrc"
)

# Remote source directory (adjust as needed)
REMOTE_SRC_DIR="${REMOTE_SRC_DIR:-/etc/skel}"

# Local destination directory
LOCAL_DEST_DIR="$HOME"

log_step "COPY-RC" "Starting to copy rc files from remote to local"

# Check if remote source directory exists
if [ ! -d "$REMOTE_SRC_DIR" ]; then
    log_warn "Remote source directory does not exist: $REMOTE_SRC_DIR"
    log_info "Trying alternative remote locations..."
    
    # Try common alternative locations
    if [ -d "/etc/skel" ]; then
        REMOTE_SRC_DIR="/etc/skel"
        log_info "Using /etc/skel as remote source directory"
    elif [ -d "/usr/local/etc/skel" ]; then
        REMOTE_SRC_DIR="/usr/local/etc/skel"
        log_info "Using /usr/local/etc/skel as remote source directory"
    else
        error_exit "Could not find a valid remote source directory"
    fi
fi

log_info "Remote source directory: $REMOTE_SRC_DIR"
log_info "Local destination directory: $LOCAL_DEST_DIR"

# Copy each rc file
for rc_file in "${RC_FILES[@]}"; do
    remote_file="$REMOTE_SRC_DIR/$rc_file"
    local_file="$LOCAL_DEST_DIR/$rc_file"
    
    log_step "COPY-RC" "Processing $rc_file"
    
    # Check if remote file exists
    if [ ! -f "$remote_file" ]; then
        log_warn "Remote file not found: $remote_file"
        continue
    fi
    
    # Check if local file already exists
    if [ -f "$local_file" ]; then
        log_info "Local file already exists: $local_file"
        
        # Create a backup
        backup_file "$local_file" "$LOCAL_DEST_DIR"
        if [ $? -eq 0 ]; then
            log_info "Backup created for existing file"
        fi
        
        # Ask user if they want to overwrite
        if confirm_action "Overwrite $local_file with remote version?" "n"; then
            cp "$remote_file" "$local_file"
            if [ $? -eq 0 ]; then
                log_info "Successfully overwritten: $local_file"
            else
                log_error "Failed to overwrite: $local_file"
            fi
        else
            log_info "Skipping $rc_file (user chose not to overwrite)"
        fi
    else
        # Copy the file since it doesn't exist locally
        cp "$remote_file" "$local_file"
        if [ $? -eq 0 ]; then
            log_info "Successfully copied: $rc_file"
        else
            log_error "Failed to copy: $rc_file"
        fi
    fi
done

log_step "COPY-RC" "Finished copying rc files"
echo
echo "Summary:"
echo "Remote source: $REMOTE_SRC_DIR"
echo "Local destination: $LOCAL_DEST_DIR"
echo "Files processed: ${RC_FILES[*]}"

