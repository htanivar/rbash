#!/bin/bash

# Source the main loader instead of individual files
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)/core-loader.sh"

must_be_root

echo "=== User Creation Script ==="
echo

# Example 1: Basic required input
echo "Attempt to create user:"
prompt_input "Enter username" "user_name"
prompt_input "Enter user password" "user_pwd"

create_user "$user_name" "$user_pwd"
echo "Created regular user: $user_name"
