#!/bin/bash

# Source the main loader instead of individual files
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)/core-loader.sh"

echo "=== Copying user rc files to local ==="
echo

# Configuration
REMOTE_USER="${REMOTE_USER:-}"
REMOTE_HOST="${REMOTE_HOST:-}"
REMOTE_SRC_DIR="${REMOTE_SRC_DIR:-}"
GITHUB_DIR="$HOME/code/github/htanivar"
SCP_OPTIONS="${SCP_OPTIONS:-}"

# Array of rc files to copy
declare -a TARGET_DIRS=(
    "$HOME/code/github/htanivar/technical-notes"
    "$HOME/code/github/htanivar/rbash"
)


prompt_input "Enter Remote username: " "REMOTE_USER" "$USER"
require_var "REMOTE_USER"
prompt_input "Enter Remote Host: " "REMOTE_HOST" "v-server"
require_var "REMOTE_HOST"


log_step "COPY-RC" "Starting to copy technotes folder"


#create_directory $TNOTES_DIR "$USER" "$USER"
create_remote_directory $REMOTE_USER $REMOTE_HOST $GITHUB_DIR

# Copy each rc file
for TARGET in "${TARGET_DIRS[@]}"; do
  copy_directory_to_remote "$TARGET" "$REMOTE_USER" "$REMOTE_HOST"  "$GITHUB_DIR"
done
