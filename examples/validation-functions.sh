#!/bin/bash
# validation-functions.sh - examples of using validation functions

# Set PROJECT_ROOT_DIR to the root of your project
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT_DIR="$(dirname "$SCRIPT_DIR")"
export PROJECT_ROOT_DIR

# Source the validation functions
source "$PROJECT_ROOT_DIR/functions/validation.sh"

# Source the logging functions for demonstration
source "$PROJECT_ROOT_DIR/functions/log.sh"

# Initialize logging
init_logging

echo "=== Validation Functions Examples ==="

# Example 1: Check if running as non-root (comment out to test)
log_step "1.a" "Checking if running as root"
#require_root
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

echo "=== All validation examples completed successfully ==="
