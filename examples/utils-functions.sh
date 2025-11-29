#!/bin/bash
# utils-functions.sh - Examples for using utility functions from utils.sh
# Make sure to source utils.sh before running these examples

# Example script demonstrating error handling functions
# Set up project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT_DIR="$(dirname "$SCRIPT_DIR")"
export PROJECT_ROOT_DIR

# Source the utility functions
source "$(dirname "$0")/../functions/utils.sh"

echo "=== Utility Functions Examples ==="

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
backup_file "/tmp/sample_file.txt" "/tmp/backups"
echo "File backed up to /tmp/backups"

# Example 3: generate_random_string
echo
echo "3. Generating random strings:"
echo "16-character random string: $(generate_random_string 16)"
echo "8-character numeric string: $(generate_random_string 8 '0-9')"
echo "20-character alphanumeric string: $(generate_random_string 20 'A-Za-z0-9')"

# Example 4: check_port
echo
echo "4. Checking port availability:"
if check_port 80; then
    echo "Port 80 is available"
else
    echo "Port 80 is in use"
fi

if check_port 8080; then
    echo "Port 8080 is available"
else
    echo "Port 8080 is in use"
fi

echo
echo "=== Examples completed ==="
