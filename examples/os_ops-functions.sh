#!/bin/bash
# utils-functions.sh - Examples for using utility functions from utils.sh

# Source the main loader instead of individual files
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/core-loader.sh"

echo "=== OS Functions Examples ==="

# Example 1: create_directory
echo
echo "1. Creating a directory:"
create_directory "/tmp/example_dir"
echo "Directory created at /tmp/example_dir"

# Example 2: backup_file
echo
echo "2. Backing up a file:"
# First, create a sample file to backup
echo "This is a test file" > /tmp/sample_file.txt
# Ensure backup directory exists
mkdir -p /tmp/backups
backup_file "/tmp/sample_file.txt" "/tmp/backups"
echo "File backed up to /tmp/backups"

# Example 3: SCP operations (from scp_ops.sh)
echo
echo "3. Examples of SCP operations:"
echo "   These functions are defined in scp_ops.sh and can be used for remote file transfers."
echo "   Available functions:"
echo "   - copy_remote_file: Copy file from remote to local"
echo "   - copy_to_remote: Copy file from local to remote"
echo "   - copy_remote_directory: Copy directory from remote to local"
echo "   - copy_directory_to_remote: Copy directory from local to remote"
echo "   - test_ssh_connection: Test SSH connection to remote host"
echo "   Usage example: copy_remote_file user example.com /home/user/file.txt /tmp/local_file.txt"
echo "   Note: These examples won't actually run without valid SSH credentials."
echo "   For detailed examples with test scenarios, run:"
echo "   bash examples/scp_ops-functions.sh"
