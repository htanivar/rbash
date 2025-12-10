#!/bin/bash

# Source the main loader instead of individual files
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)/core-loader.sh"

echo "=== Copying user rc files to local ==="
echo

# Configuration
REMOTE_USER="${REMOTE_USER:-}"
REMOTE_HOST="${REMOTE_HOST:-}"
REMOTE_SRC_DIR="${REMOTE_SRC_DIR:-}"
SCP_OPTIONS="${SCP_OPTIONS:-}"

# Array of rc files to copy
declare -a RC_FILES=(
    ".bashrc"
    ".zshrc"
    ".commonrc"
)

prompt_input "Enter Remote username: " "REMOTE_USER" "$USER"
require_var "REMOTE_USER"
prompt_input "Enter Remote Host: " "REMOTE_HOST" "v-server"
require_var "REMOTE_HOST"


log_step "COPY-PROFILE" "Starting to copy bash files"



# Copy each rc file
for FILE in "${RC_FILES[@]}"; do
  log_command "  copy_to_remote $HOME/$FILE $REMOTE_USER $REMOTE_HOST  $HOME/$FILE"
  copy_to_remote $HOME"/"$FILE "$REMOTE_USER" "$REMOTE_HOST"  $HOME"/"$FILE
done
