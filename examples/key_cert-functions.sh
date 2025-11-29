#!/bin/bash

# Source the main loader instead of individual files
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/core-loader.sh"

# Example 1: Generate SSH key
log_info "Generating SSH key"
ssh_key_dir="/tmp/test_ssh_keys_$$"
ssh_key_path="$ssh_key_dir/test_key"
# Create the directory using create_directory function
create_directory "$ssh_key_dir"
# Generate a key with a simple name in the test directory
if generate_ssh_key "$ssh_key_path" "test@example.com" "rsa" 2048; then
    echo "   SSH key generated successfully in directory: ${ssh_key_dir}"
    log_info "SSH key generated in directory: ${ssh_key_dir}"
    # List the generated files
    echo "   Generated files:"
    ls -la "$ssh_key_dir" | while read line; do
        echo "      $line"
    done
    # Clean up the test key
    rm -rf "$ssh_key_dir"
else
    echo "   SSH key generation failed"
    log_error "SSH key generation failed"
    # Clean up on failure too
    rm -rf "$ssh_key_dir"
fi
echo
