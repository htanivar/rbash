#!/bin/bash

source "$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)/core-loader.sh"

echo "=== Copying user rc files to remote ==="
echo

SSH_USER="${SSH_USER:-}"
REMOTE_HOST="${REMOTE_HOST:-}"
TARGET_USER="${TARGET_USER:-}"
USE_SUDO="${USE_SUDO:-no}"

RC_FILES=(
  ".bashrc"
  ".zshrc"
  ".commonrc"
)

shopt -s nullglob
for f in "$HOME"/.aider/*.yml; do
  RC_FILES+=("${f#$HOME/}")
done
shopt -u nullglob

# Get SSH credentials (for authentication)
prompt_input "Enter SSH username (for authentication): " "SSH_USER" "$USER"
require_var "SSH_USER"
prompt_input "Enter Remote Host: " "REMOTE_HOST" "v-server"
require_var "REMOTE_HOST"

# Ask for target user (where files will be placed)
prompt_input "Enter target username (where files will be placed): " "TARGET_USER" "$SSH_USER"
require_var "TARGET_USER"

# Determine if we need sudo
if [[ "$SSH_USER" != "$TARGET_USER" ]]; then
    echo "SSH user ($SSH_USER) is different from target user ($TARGET_USER)."
    echo "Will use sudo to copy files to target user's home directory."
    USE_SUDO="yes"
else
    USE_SUDO="no"
fi

# Establish single SSH session (password asked once)
ssh -o ControlMaster=yes -o ControlPersist=10m -o ControlPath=~/.ssh/cm-%r@%h:%p \
  "$SSH_USER@$REMOTE_HOST" "exit" || exit 1

log_step "COPY-PROFILE" "Starting to copy rc files to $TARGET_USER@$REMOTE_HOST"

for FILE in "${RC_FILES[@]}"; do
    LOCAL_FILE="$HOME/$FILE"
    if [[ ! -f "$LOCAL_FILE" ]]; then
        log_command "  Skipping $FILE (not found locally)"
        continue
    fi
    
    # Determine remote path
    if [[ "$USE_SUDO" == "yes" ]]; then
        # Get target user's home directory
        # First, find the home directory on the remote system
        TARGET_HOME=$(ssh -o ControlPath=~/.ssh/cm-%r@%h:%p \
            "$SSH_USER@$REMOTE_HOST" \
            "sudo -u '$TARGET_USER' sh -c 'echo \$HOME'")
        if [[ -z "$TARGET_HOME" ]]; then
            TARGET_HOME="/home/$TARGET_USER"
        fi
        REMOTE_PATH="$TARGET_HOME/$FILE"
        
        log_command "  Copying $FILE to $REMOTE_PATH (using sudo)"
        
        # Use ssh with sudo tee to write the file
        # First, ensure the directory exists
        REMOTE_DIR=$(dirname "$REMOTE_PATH")
        ssh -o ControlPath=~/.ssh/cm-%r@%h:%p \
            "$SSH_USER@$REMOTE_HOST" \
            "sudo mkdir -p '$REMOTE_DIR' && sudo chown '$TARGET_USER:$TARGET_USER' '$REMOTE_DIR' 2>/dev/null || true"
        
        # Copy the file content using sudo tee
        cat "$LOCAL_FILE" | ssh -o ControlPath=~/.ssh/cm-%r@%h:%p \
            "$SSH_USER@$REMOTE_HOST" \
            "sudo tee '$REMOTE_PATH' > /dev/null"
        
        # Set correct ownership
        ssh -o ControlPath=~/.ssh/cm-%r@%h:%p \
            "$SSH_USER@$REMOTE_HOST" \
            "sudo chown '$TARGET_USER:$TARGET_USER' '$REMOTE_PATH'"
    else
        # Same user, use regular scp
        REMOTE_PATH="~/$FILE"
        log_command "  Copying $FILE to $SSH_USER@$REMOTE_HOST:$REMOTE_PATH"
        scp -o ControlPath=~/.ssh/cm-%r@%h:%p \
            "$LOCAL_FILE" "$SSH_USER@$REMOTE_HOST:$REMOTE_PATH"
    fi
    
    if [[ $? -eq 0 ]]; then
        log_command "    ✓ Successfully copied $FILE"
    else
        log_command "    ✗ Failed to copy $FILE"
    fi
done

# Close master connection
ssh -O exit -o ControlPath=~/.ssh/cm-%r@%h:%p \
  "$SSH_USER@$REMOTE_HOST"

echo
echo "=== Copy completed ==="
