#!/bin/bash

# Source the main loader instead of individual files
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/core-loader.sh"

# Example 1: Add directories to PATH
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

# Example 2: Create path link
log_info "Creating symbolic link"
test_source="/tmp/test_source_$$"
test_link_name="test_link_$$"
echo "test content" > "$test_source"
if create_path_link "$test_source" "$test_link_name"; then
    echo "   Symbolic link created successfully"
    log_info "Symbolic link created: $test_source -> $test_link_name"
    # Verify the link
    bin_dir="${HOME}/.local/bin"
    link_path="$bin_dir/$test_link_name"
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
bin_dir="${HOME}/.local/bin"
link_path="$bin_dir/$test_link_name"
if [ -L "$link_path" ]; then
    rm -f "$link_path"
    log_debug "Cleaned up test link: $link_path"
fi
echo

log_info "Examples complete"
echo "=== Examples Complete ==="
echo "Check the log file at: $DEFAULT_LOG_FILE"
