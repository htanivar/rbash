#!/bin/bash
# network.sh - Examples for using utility functions from utils.sh

# Source the main loader instead of individual files
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/core-loader.sh"

# Example : check_port
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
