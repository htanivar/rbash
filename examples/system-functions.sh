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

# Example 3: Check if distribution is supported
log_info "Checking distribution support"
# Let's check against a list of common distributions
supported_distros="ubuntu debian centos fedora"
# Since check_distribution may call error_exit which exits the script, we need to handle it
# We'll run it in a subshell to prevent the entire script from exiting
if (check_distribution "$supported_distros" >/dev/null 2>&1); then
    echo "   Distribution check passed!"
    log_info "Distribution check passed for: $distribution"
else
    echo "   Distribution check failed!"
    log_warn "Distribution check failed for: $distribution"
fi
echo

# Example 4: Using check_distribution in a conditional
log_info "Performing conditional distribution check"
echo "4. Conditional distribution check:"
# Check for specific distribution types
if (check_distribution "ubuntu debian" >/dev/null 2>&1); then
    echo "   This is a Debian-based system"
    log_info "Detected Debian-based system"
elif (check_distribution "centos fedora rhel" >/dev/null 2>&1); then
    echo "   This is a Red Hat-based system"
    log_info "Detected Red Hat-based system"
else
    echo "   This is an unsupported system type"
    log_warn "Detected unsupported system type"
fi
echo

log_info "Examples complete"
echo "=== Examples Complete ==="
echo "Check the log file at: $DEFAULT_LOG_FILE"
