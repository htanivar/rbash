#!/bin/bash


RAVI_LINUX="/home/ravi/.ssh/id_rsa"
AI_LINUX="/home/ravi/.ssh/ai-linux_id"

# --- SSH Agent ---
# Start the SSH agent and add the SSH key if not already running
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)"
    ssh-add $RAVI_LINUX
    ssh-add $AI_LINUX
fi