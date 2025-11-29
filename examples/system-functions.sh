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

# Example 5: Generate SSH key
log_info "Generating SSH key"
ssh_key_dir="/tmp/test_ssh_keys_$$"
ssh_key_path="$ssh_key_dir/test_key"
# Create the directory using create_directory function
create_directory "$ssh_key_dir"
# Generate a key with a simple name in the test directory
if generate_ssh_key "$ssh_key_path" "test@example.com" "rsa" 2048; then
    echo "   SSH key generated successfully in directory: ${ssh_key_dir}"
    log_info "SSH key generated in directory: ${ssh_key_dir}"
    # List the generated files
    echo "   Generated files:"
    ls -la "$ssh_key_dir" | while read line; do
        echo "      $line"
    done
    # Clean up the test key
    rm -rf "$ssh_key_dir"
else
    echo "   SSH key generation failed"
    log_error "SSH key generation failed"
    # Clean up on failure too
    rm -rf "$ssh_key_dir"
fi
echo

# Example 6: Add directories to PATH
log_info "Adding directories to PATH"
test_dir1="/tmp/test_path_$$_1"
test_dir2="/tmp/test_path_$$_2"
mkdir -p "$test_dir1" "$test_dir2"
if add_to_path "$test_dir1" "$test_dir2"; then
    echo "   Directories added to PATH successfully"
    log_info "Directories added to PATH: $test_dir1, $test_dir2"
    # Show that they're in PATH
    if [[ ":$PATH:" == *":$test_dir1:"* ]] && [[ ":$PATH:" == *":$test_dir2:"* ]]; then
        echo "   Verified: directories are in PATH"
    fi
else
    echo "   Failed to add directories to PATH"
    log_error "Failed to add directories to PATH"
fi
# Clean up test directories
rm -rf "$test_dir1" "$test_dir2"
echo

# Example 7: Create path link
log_info "Creating symbolic link"
test_source="/tmp/test_source_$$"
test_link_name="test_link_$$"
echo "test content" > "$test_source"
if create_path_link "$test_source" "$test_link_name"; then
    echo "   Symbolic link created successfully"
    log_info "Symbolic link created: $test_source -> $test_link_name"
    # Verify the link
    local bin_dir="${HOME}/.local/bin"
    local link_path="$bin_dir/$test_link_name"
    if [[ -L "$link_path" ]] && [[ "$(readlink "$link_path")" == "$test_source" ]]; then
        echo "   Verified: link points to source"
        log_debug "Link verification passed: $link_path -> $test_source"
    else
        echo "   Warning: link verification failed"
        log_warn "Link verification failed: $link_path"
    fi
else
    echo "   Failed to create symbolic link"
    log_error "Failed to create symbolic link"
fi
# Clean up
rm -f "$test_source"
# Remove the created link
local bin_dir="${HOME}/.local/bin"
local link_path="$bin_dir/$test_link_name"
if [ -L "$link_path" ]; then
    rm -f "$link_path"
    log_debug "Cleaned up test link: $link_path"
fi
echo

log_info "Examples complete"
echo "=== Examples Complete ==="
echo "Check the log file at: $DEFAULT_LOG_FILE"
