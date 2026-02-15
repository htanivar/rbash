#!/bin/bash

source "$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)/core-loader.sh"

echo "=== Copying user rc files to local ==="
echo

REMOTE_USER="${REMOTE_USER:-}"
REMOTE_HOST="${REMOTE_HOST:-}"
REMOTE_SRC_DIR="${REMOTE_SRC_DIR:-}"
SCP_OPTIONS="${SCP_OPTIONS:-}"

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

prompt_input "Enter Remote username: " "REMOTE_USER" "$USER"
require_var "REMOTE_USER"
prompt_input "Enter Remote Host: " "REMOTE_HOST" "v-server"
require_var "REMOTE_HOST"

# Establish single SSH session (password asked once)
ssh -o ControlMaster=yes -o ControlPersist=10m -o ControlPath=~/.ssh/cm-%r@%h:%p \
  "$REMOTE_USER@$REMOTE_HOST" "exit" || exit 1

log_step "COPY-PROFILE" "Starting to copy bash files"

for FILE in "${RC_FILES[@]}"; do
  log_command "  copy_to_remote $HOME/$FILE $REMOTE_USER $REMOTE_HOST $HOME/$FILE"
  scp -o ControlPath=~/.ssh/cm-%r@%h:%p \
    "$HOME/$FILE" "$REMOTE_USER@$REMOTE_HOST:$HOME/$FILE"
done

# Close master connection
ssh -O exit -o ControlPath=~/.ssh/cm-%r@%h:%p \
  "$REMOTE_USER@$REMOTE_HOST"
