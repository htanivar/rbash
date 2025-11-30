#!/bin/bash

# Source the main loader instead of individual files
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)/core-loader.sh"

must_be_root

echo "=== User Delete Script ==="
echo

# Example 1: Basic required input
echo "Attempt to Delete user:"
prompt_input "Enter username" "user_name"

create_user "$user_name"
echo "Deleted regular user: $user_name"
