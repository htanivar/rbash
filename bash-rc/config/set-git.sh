#!/bin/bash

# Default values
DEFAULT_NAME="Ravi J"
DEFAULT_EMAIL="raviregi@gmail.com"

log_debug "  Name : $DEFAULT_NAME"
log_debug "  Email: $DEFAULT_EMAIL"

# Apply Git config
git config --global user.name "$DEFAULT_NAME"
git config --global user.email "$DEFAULT_EMAIL"

#Excluding git to validate the owner for the directory
git config --global --add safe.directory /apps/flutter
log_debug "  added git safe direcotry : /apps/flutter"

# Confirm
echo -e "\n✅ Git config set successfully: $DEFAULT_NAME $DEFAULT_EMAIL "

