#!/bin/bash
# system-functions.sh - examples of using system utility functions

# Source the main loader instead of individual files
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/core-loader.sh"


echo "=== System Functions Examples ==="
echo

# Example 1: Get current user
log_info "Getting current user"
current_user=$(get_current_user)
echo "   Current user: $current_user"
log_debug "Current user retrieved: $current_user"
echo

# Example 2: Get distribution information
log_info "Getting distribution information"
distribution=$(get_distribution)
echo "   Distribution: $distribution"
log_debug "Distribution retrieved: $distribution"
echo

