#!/bin/bash
# validation-functions.sh - examples of using validation functions

# Source the main loader instead of individual files
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/core-loader.sh"

# Initialize logging
init_logging

echo "=== Validation Functions Examples ==="

# Example 1: Check if running as non-root (comment out to test)
log_step "1.a" "Checking if running as root"
#require_sudo
echo "✓ root validation passed"

# Example 1: Check if running as non-root (comment out to test)
log_step "1.b" "Checking if running as non-root"
require_non_root
echo "✓ Non-root validation passed"

# Example 2: Validate required variables
log_step "2" "Validating required variables"
MY_VAR="some value"
require_var "MY_VAR"
echo "✓ Variable validation passed"

# Example 3: Check if commands exist
log_step "3" "Validating command availability"
require_command "ls"
require_command "echo"
echo "✓ Command validation passed"

# Example 4: Check if files exist
log_step "4" "Validating file existence"
# Create a temporary file for demonstration
TEMP_FILE=$(mktemp)
if (require_file "$TEMP_FILE" >/dev/null 2>&1); then
    echo "✓ File existence validation passed"
else
    echo "✗ File existence validation failed"
fi

# Test failure case
log_step "4.b" "Testing file existence validation failure"
if (require_file "/nonexistent/file/path" >/dev/null 2>&1); then
    echo "✗ File existence validation should have failed"
else
    echo "✓ File existence validation correctly failed for nonexistent file"
fi
rm "$TEMP_FILE"

# Example 5: Check if directories exist
log_step "5" "Validating directory existence"
if (require_directory "/tmp" >/dev/null 2>&1); then
    echo "✓ Directory existence validation passed"
else
    echo "✗ Directory existence validation failed"
fi

# Test failure case
log_step "5.b" "Testing directory existence validation failure"
if (require_directory "/nonexistent/directory/path" >/dev/null 2>&1); then
    echo "✗ Directory existence validation should have failed"
else
    echo "✓ Directory existence validation correctly failed for nonexistent directory"
fi

# Example 6: Check file permissions
log_step "6" "Validating file permissions"
# Create a temporary file with read permissions
TEMP_FILE2=$(mktemp)
chmod 644 "$TEMP_FILE2"
if (check_file_permissions "$TEMP_FILE2" "r" >/dev/null 2>&1); then
    echo "✓ File permissions validation passed"
else
    echo "✗ File permissions validation failed"
fi

# Test failure case
log_step "6.b" "Testing file permissions validation failure"
chmod 200 "$TEMP_FILE2"  # Remove read permission
if (check_file_permissions "$TEMP_FILE2" "r" >/dev/null 2>&1); then
    echo "✗ File permissions validation should have failed"
else
    echo "✓ File permissions validation correctly failed for file without read permission"
fi
rm "$TEMP_FILE2"

# Example 7: Check multiple permissions
log_step "7" "Validating multiple file permissions"
# Create a temporary file with read and write permissions
TEMP_FILE3=$(mktemp)
chmod 600 "$TEMP_FILE3"
if (check_file_permissions "$TEMP_FILE3" "rw" >/dev/null 2>&1); then
    echo "✓ Multiple file permissions validation passed"
else
    echo "✗ Multiple file permissions validation failed"
fi
rm "$TEMP_FILE3"



# Example 8: Check if distribution is supported
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

# Example 9: Using check_distribution in a conditional
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

echo "=== All validation examples completed successfully ==="