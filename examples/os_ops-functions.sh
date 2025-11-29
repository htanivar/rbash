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
backup_file "/tmp/sample_file.txt" "/tmp/backups"
echo "File backed up to /tmp/backups"
