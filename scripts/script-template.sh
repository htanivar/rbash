#!/bin/bash


# Source the main loader instead of individual files
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/core-loader.sh"

echo "=== Input Functions Examples ==="
echo

# Example 1: Basic required input
echo "1. Basic required input:"
prompt_input "Enter your name" "user_name"
echo "Hello, $user_name!"
echo