#!/bin/bash
# scp_ops-functions.sh - Examples for using SCP operations functions from scp_ops.sh

# Source the main loader instead of individual files
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/core-loader.sh"

echo "=== SCP Operations Functions Examples ==="
echo

# Set up test variables
TEST_USER="${TEST_USER:-$(whoami)}"
TEST_HOST="${TEST_HOST:-localhost}"
TEST_TEMP_DIR="/tmp/scp_test_$(date +%s)"
LOCAL_TEST_DIR="$TEST_TEMP_DIR/local"
REMOTE_TEST_DIR="$TEST_TEMP_DIR/remote"

# Create test directories
mkdir -p "$LOCAL_TEST_DIR"
mkdir -p "$REMOTE_TEST_DIR"

echo "Test configuration:"
echo "  User: $TEST_USER"
echo "  Host: $TEST_HOST"
echo "  Local test directory: $LOCAL_TEST_DIR"
echo "  Remote test directory: $REMOTE_TEST_DIR"
echo

# Create test files
echo "Creating test files..."
echo "This is a local test file." > "$LOCAL_TEST_DIR/local_file.txt"
echo "This is a local test file for directory copy." > "$LOCAL_TEST_DIR/file1.txt"
echo "This is another local test file." > "$LOCAL_TEST_DIR/file2.txt"
mkdir -p "$LOCAL_TEST_DIR/subdir"
echo "File in subdirectory." > "$LOCAL_TEST_DIR/subdir/file3.txt"

echo "Local test files created:"
find "$LOCAL_TEST_DIR" -type f | sort
echo

# Example 1: Test SSH connection
echo "1. Testing SSH connection to $TEST_USER@$TEST_HOST"
echo "   Note: This will only work if SSH is properly configured."
echo "   You can set TEST_USER and TEST_HOST environment variables to test with different hosts."
echo "   Example: TEST_USER=user TEST_HOST=example.com bash examples/scp_ops-functions.sh"
echo

if [ "$TEST_HOST" != "localhost" ]; then
    if test_ssh_connection "$TEST_USER" "$TEST_HOST"; then
        echo "   ✓ SSH connection test successful"
    else
        echo "   ✗ SSH connection test failed"
        echo "   Continuing with examples (some may fail)..."
    fi
else
    echo "   Skipping SSH test (localhost is not a valid remote host for SSH)"
fi
echo

# Example 2: Copy file from remote to local (simulated)
echo "2. Example: copy_remote_file"
echo "   Function: copy_remote_file remote_user remote_host remote_path local_path [scp_options]"
echo "   This would copy a file from remote to local."
echo "   Example command:"
echo "   copy_remote_file \"$TEST_USER\" \"$TEST_HOST\" \"/etc/hostname\" \"$LOCAL_TEST_DIR/remote_hostname.txt\""
echo

# Create a simulated remote file for demonstration
if [ "$TEST_HOST" = "localhost" ]; then
    cp /etc/hostname "$REMOTE_TEST_DIR/hostname"
    echo "   Simulating remote file copy (since host is localhost)..."
    if copy_remote_file "$TEST_USER" "$TEST_HOST" "$REMOTE_TEST_DIR/hostname" "$LOCAL_TEST_DIR/copied_hostname.txt"; then
        echo "   ✓ File copy example demonstrated"
        echo "   Copied content: $(cat "$LOCAL_TEST_DIR/copied_hostname.txt" 2>/dev/null || echo "N/A")"
    else
        echo "   ✗ File copy failed (expected for non-localhost without SSH setup)"
    fi
else
    echo "   To actually test, ensure SSH access to $TEST_HOST"
    echo "   Uncomment the line below to test:"
    echo "   # copy_remote_file \"$TEST_USER\" \"$TEST_HOST\" \"/etc/hostname\" \"$LOCAL_TEST_DIR/remote_hostname.txt\""
fi
echo

# Example 3: Copy file to remote
echo "3. Example: copy_to_remote"
echo "   Function: copy_to_remote local_path remote_user remote_host remote_path [scp_options]"
echo "   This would copy a file from local to remote."
echo "   Example command:"
echo "   copy_to_remote \"$LOCAL_TEST_DIR/local_file.txt\" \"$TEST_USER\" \"$TEST_HOST\" \"$REMOTE_TEST_DIR/uploaded_file.txt\""
echo

if [ "$TEST_HOST" = "localhost" ]; then
    echo "   Simulating local to local copy (since host is localhost)..."
    mkdir -p "$REMOTE_TEST_DIR"
    if copy_to_remote "$LOCAL_TEST_DIR/local_file.txt" "$TEST_USER" "$TEST_HOST" "$REMOTE_TEST_DIR/uploaded_file.txt"; then
        echo "   ✓ File upload example demonstrated"
        echo "   Uploaded file exists: $(ls -la "$REMOTE_TEST_DIR/uploaded_file.txt" 2>/dev/null | wc -l)"
    else
        echo "   ✗ File upload failed"
    fi
else
    echo "   To actually test, ensure SSH access to $TEST_HOST"
    echo "   Uncomment the line below to test:"
    echo "   # copy_to_remote \"$LOCAL_TEST_DIR/local_file.txt\" \"$TEST_USER\" \"$TEST_HOST\" \"$REMOTE_TEST_DIR/uploaded_file.txt\""
fi
echo

# Example 4: Copy directory from remote to local
echo "4. Example: copy_remote_directory"
echo "   Function: copy_remote_directory remote_user remote_host remote_path local_path [scp_options]"
echo "   This would copy a directory recursively from remote to local."
echo "   Example command:"
echo "   copy_remote_directory \"$TEST_USER\" \"$TEST_HOST\" \"$REMOTE_TEST_DIR\" \"$LOCAL_TEST_DIR/remote_copy\""
echo

if [ "$TEST_HOST" = "localhost" ]; then
    # Create a test remote directory structure
    mkdir -p "$REMOTE_TEST_DIR/remote_dir"
    echo "Remote file 1" > "$REMOTE_TEST_DIR/remote_dir/rfile1.txt"
    echo "Remote file 2" > "$REMOTE_TEST_DIR/remote_dir/rfile2.txt"
    mkdir -p "$REMOTE_TEST_DIR/remote_dir/sub"
    echo "Remote sub file" > "$REMOTE_TEST_DIR/remote_dir/sub/rfile3.txt"
    
    echo "   Simulating remote directory copy (since host is localhost)..."
    if copy_remote_directory "$TEST_USER" "$TEST_HOST" "$REMOTE_TEST_DIR/remote_dir" "$LOCAL_TEST_DIR/remote_dir_copy"; then
        echo "   ✓ Directory copy example demonstrated"
        echo "   Copied files:"
        find "$LOCAL_TEST_DIR/remote_dir_copy" -type f 2>/dev/null | while read -r file; do
            echo "     - $file"
        done || true
    else
        echo "   ✗ Directory copy failed"
    fi
else
    echo "   To actually test, ensure SSH access to $TEST_HOST"
    echo "   Uncomment the line below to test:"
    echo "   # copy_remote_directory \"$TEST_USER\" \"$TEST_HOST\" \"$REMOTE_TEST_DIR\" \"$LOCAL_TEST_DIR/remote_copy\""
fi
echo

# Example 5: Copy directory to remote
echo "5. Example: copy_directory_to_remote"
echo "   Function: copy_directory_to_remote local_path remote_user remote_host remote_path [scp_options]"
echo "   This would copy a directory recursively from local to remote."
echo "   Example command:"
echo "   copy_directory_to_remote \"$LOCAL_TEST_DIR\" \"$TEST_USER\" \"$TEST_HOST\" \"$REMOTE_TEST_DIR/local_copy\""
echo

if [ "$TEST_HOST" = "localhost" ]; then
    echo "   Simulating local directory upload (since host is localhost)..."
    if copy_directory_to_remote "$LOCAL_TEST_DIR" "$TEST_USER" "$TEST_HOST" "$REMOTE_TEST_DIR/local_copy"; then
        echo "   ✓ Directory upload example demonstrated"
        echo "   Uploaded directory exists: $(ls -la "$REMOTE_TEST_DIR/local_copy" 2>/dev/null | wc -l)"
    else
        echo "   ✗ Directory upload failed"
    fi
else
    echo "   To actually test, ensure SSH access to $TEST_HOST"
    echo "   Uncomment the line below to test:"
    echo "   # copy_directory_to_remote \"$LOCAL_TEST_DIR\" \"$TEST_USER\" \"$TEST_HOST\" \"$REMOTE_TEST_DIR/local_copy\""
fi
echo

# Example 6: Using SCP options
echo "6. Example: Using SCP options"
echo "   All SCP functions accept optional scp_options parameter."
echo "   Common options:"
echo "   -P <port>          Specify port number"
echo "   -i <identity_file> Specify identity (private key) file"
echo "   -C                 Enable compression"
echo "   -q                 Quiet mode"
echo "   Example:"
echo "   copy_remote_file \"$TEST_USER\" \"$TEST_HOST\" \"/path/to/file\" \"/local/path\" \"-P 2222 -i ~/.ssh/id_rsa\""
echo

# Cleanup
echo "Cleaning up test directories..."
rm -rf "$TEST_TEMP_DIR"
echo "Test directories removed: $TEST_TEMP_DIR"
echo

echo "=== SCP Operations Examples Completed ==="
echo
echo "Summary:"
echo "All SCP functions have been demonstrated with examples."
echo "To actually test with a real remote host, set the environment variables:"
echo "  export TEST_USER='your_username'"
echo "  export TEST_HOST='remote.example.com'"
echo "  bash examples/scp_ops-functions.sh"
echo
echo "Note: Ensure SSH key-based authentication is set up for password-less connections."
