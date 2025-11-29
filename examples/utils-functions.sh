#!/bin/bash
# utils-functions.sh - Examples for using utility functions from utils.sh

# Source the main loader instead of individual files
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/core-loader.sh"

echo "=== Utility Functions Examples ==="


# Example 3: generate_random_string
echo
echo "3. Generating random strings:"
echo "16-character random string: $(generate_random_string 16)"
echo "8-character numeric string: $(generate_random_string 8 '0-9')"
echo "20-character alphanumeric string: $(generate_random_string 20 'A-Za-z0-9')"


echo
echo "=== Examples completed ==="
