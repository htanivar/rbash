#!/bin/bash

# Source the main loader instead of individual files
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)/core-loader.sh"

echo "=== Efficient Notes Sync (rsync-based) ==="
echo "Excluding patterns: .git/, .todo, .aider*, log/, logs/, .*.swp"
echo "Add more patterns by editing EXCLUDE_PATTERNS array in the script."
echo

# Configuration
REMOTE_USER="${REMOTE_USER:-}"
REMOTE_HOST="${REMOTE_HOST:-}"
GITHUB_DIR="$HOME/code/github/htanivar"

# Directories to sync
TARGET_DIRS=(
    "$HOME/code/github/htanivar/technical-notes"
    "$HOME/code/github/htanivar/rbash"
)

# Exclude patterns for rsync
EXCLUDE_PATTERNS=(
    '.git/'
    '.todo'
    '.idea'
    '.aider*'
    'log/'
    'logs/'
    '*logs*'
    '.*.swp'  # Vim swap files
)

# Get user input
prompt_input "Enter Remote username: " "REMOTE_USER" "$USER"
require_var "REMOTE_USER"
prompt_input "Enter Remote Host: " "REMOTE_HOST" "v-server"
require_var "REMOTE_HOST"

# Setup logging
LOG_DIR="../logs/copy-notes/"
mkdir -p "$LOG_DIR"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="$LOG_DIR/sync_${TIMESTAMP}.log"

# Setup deleted files directory
DELETED_DIR="$LOG_DIR/deleted"
mkdir -p "$DELETED_DIR"

# Function to log messages
log_message() {
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[$timestamp] $1" | tee -a "$LOG_FILE"
}

# Start logging
log_message "=== Starting sync operation ==="
log_message "Remote user: $REMOTE_USER"
log_message "Remote host: $REMOTE_HOST"
log_message "GitHub directory: $GITHUB_DIR"

# Check for rsync and ssh
if ! command -v rsync >/dev/null 2>&1; then
    log_message "ERROR: rsync is required but not installed."
    echo "ERROR: rsync is required but not installed. Install it with:"
    echo "  sudo apt-get install rsync   # Debian/Ubuntu"
    echo "  sudo yum install rsync       # RHEL/CentOS"
    echo "  brew install rsync           # macOS"
    exit 1
fi

if ! command -v ssh >/dev/null 2>&1; then
    log_message "ERROR: ssh is required but not installed."
    echo "ERROR: ssh is required but not installed."
    exit 1
fi

# Set up SSH ControlMaster to reuse a single connection
SSH_CONTROL_PATH="$HOME/.ssh/controlmasters/%r@%h:%p"
SSH_CONTROL_DIR=$(dirname "$SSH_CONTROL_PATH")
mkdir -p "$SSH_CONTROL_DIR"

# Note about SSH authentication
log_message "Note: SSH will prompt for a password only once if keys are not set up."
echo "Note: SSH will prompt for a password only once if keys are not set up."
echo "This is normal and expected behavior."

# Test SSH connection with ControlMaster
echo "Testing SSH connection to $REMOTE_USER@$REMOTE_HOST..."
echo "You will be prompted for your password now (only once)."
log_message "Testing SSH connection with ControlMaster setup"

# Start the master connection
ssh -o ControlMaster=yes -o ControlPersist=10m -o ControlPath="$SSH_CONTROL_PATH" \
    "$REMOTE_USER@$REMOTE_HOST" "echo 'SSH connection test successful'" 2>&1 | tee -a "$LOG_FILE"
SSH_TEST_EXIT=$?

if [ $SSH_TEST_EXIT -ne 0 ]; then
    log_message "ERROR: Failed to establish SSH connection to $REMOTE_USER@$REMOTE_HOST"
    echo "ERROR: Failed to establish SSH connection to $REMOTE_USER@$REMOTE_HOST"
    echo "This could be due to:"
    echo "1. Incorrect username or host"
    echo "2. Network issues"
    echo "3. Authentication failure"
    echo "4. SSH service not running on remote host"
    exit 1
fi

log_message "SSH connection established successfully"

# Try to create remote directory using the master connection
log_message "Ensuring remote directory exists: $GITHUB_DIR"
echo "Ensuring remote directory exists: $GITHUB_DIR"
ssh -o ControlPath="$SSH_CONTROL_PATH" "$REMOTE_USER@$REMOTE_HOST" \
    "mkdir -p \"$GITHUB_DIR\"" 2>&1 | tee -a "$LOG_FILE"
MKDIR_EXIT=$?

if [ $MKDIR_EXIT -ne 0 ]; then
    log_message "WARNING: Failed to create remote directory. May have permission issues."
    echo "WARNING: Failed to create remote directory. May have permission issues."
    echo "Continuing, but sync may fail..."
fi

# Function to backup deleted files
backup_deleted_files() {
    local source_dir="$1"
    local remote_path="$2"
    local basename="$3"
    
    log_message "Checking for files to be deleted in $basename..."
    
    # Get list of files on remote
    local remote_list=$(mktemp)
    local source_list=$(mktemp)
    local to_delete_list=$(mktemp)
    
    # Build find command to exclude directory patterns
    # We'll handle directory patterns from EXCLUDE_PATTERNS that end with /
    local remote_find_cmd="find \"$remote_path\" -type f"
    local local_find_cmd="find . -type f"
    
    for pattern in "${EXCLUDE_PATTERNS[@]}"; do
        if [[ "$pattern" == */ ]]; then
            local dir_name="${pattern%/}"
            remote_find_cmd="$remote_find_cmd -not -path \"*/$dir_name/*\""
            local_find_cmd="$local_find_cmd -not -path \"*/$dir_name/*\""
        fi
    done
    
    remote_find_cmd="$remote_find_cmd 2>/dev/null | sort"
    local_find_cmd="$local_find_cmd | sed 's|^\./||' | sort"
    
    # Get remote file list
    ssh -o ControlPath="$SSH_CONTROL_PATH" "$REMOTE_USER@$REMOTE_HOST" \
        "$remote_find_cmd" > "$remote_list" 2>/dev/null
    
    # Get local file list
    (cd "$source_dir" && eval "$local_find_cmd") > "$source_list" 2>/dev/null
    
    # If we couldn't get remote list, skip
    if [ ! -s "$remote_list" ]; then
        log_message "Could not retrieve remote file list. Skipping deleted files backup."
        rm -f "$remote_list" "$source_list" "$to_delete_list"
        return 0
    fi
    
    # Process remote paths to be relative to remote_path
    sed -i "s|^$remote_path/||" "$remote_list" 2>/dev/null
    sed -i "s|^$remote_path||" "$remote_list" 2>/dev/null
    
    # Find files that are on remote but not locally
    comm -23 "$remote_list" "$source_list" > "$to_delete_list"
    
    local deleted_count=$(wc -l < "$to_delete_list")
    if [ "$deleted_count" -gt 0 ]; then
        log_message "Found $deleted_count file(s) that exist on remote but not locally (will be deleted)"
        
        # Create a timestamped directory for this sync's deleted files
        local backup_dir="$DELETED_DIR/${TIMESTAMP}_${basename}"
        mkdir -p "$backup_dir"
        
        # Download each file before it gets deleted
        while IFS= read -r file; do
            if [ -n "$file" ]; then
                local remote_file="$remote_path/$file"
                local local_backup="$backup_dir/$file"
                
                # Create directory structure in backup
                mkdir -p "$(dirname "$local_backup")"
                
                log_message "Backing up deleted file: $file"
                scp -o ControlPath="$SSH_CONTROL_PATH" \
                    "$REMOTE_USER@$REMOTE_HOST:\"$remote_file\"" "$local_backup" 2>/dev/null
                if [ $? -eq 0 ]; then
                    log_message "Successfully backed up: $file"
                else
                    log_message "Failed to backup: $file"
                fi
            fi
        done < "$to_delete_list"
        
        log_message "Deleted files backed up to: $backup_dir"
    else
        log_message "No files to be deleted found."
    fi
    
    rm -f "$remote_list" "$source_list" "$to_delete_list"
}

# Sync each directory
for TARGET in "${TARGET_DIRS[@]}"; do
    if [ ! -d "$TARGET" ]; then
        log_message "WARNING: Source directory '$TARGET' does not exist. Skipping."
        echo "WARNING: Source directory '$TARGET' does not exist. Skipping."
        continue
    fi
    
    BASENAME=$(basename "$TARGET")
    REMOTE_PATH="$GITHUB_DIR/$BASENAME"
    
    log_message "Starting sync of $TARGET to $REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH"
    echo
    echo "Syncing: $TARGET"
    echo "    to: $REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH"
    
    # First, backup files that will be deleted
    backup_deleted_files "$TARGET" "$REMOTE_PATH" "$BASENAME"
    
    echo "Starting rsync transfer..."
    echo "You may be prompted for your SSH password if keys are not configured."
    
    # Create a temporary file to capture rsync's itemized changes
    TEMP_LOG=$(mktemp)
    
    # Build exclude options for rsync
    RSYNC_EXCLUDE_OPTS=()
    for pattern in "${EXCLUDE_PATTERNS[@]}"; do
        RSYNC_EXCLUDE_OPTS+=(--exclude="$pattern")
    done
    
    # rsync with --itemize-changes to log what's being transferred
    # The output format shows what happened to each file
    log_message "File transfer details for $BASENAME:"
    log_message "Excluding patterns: ${EXCLUDE_PATTERNS[*]}"
    # Use --delete to remove files on remote that don't exist locally
    rsync -avzi --update --delete --progress \
        "${RSYNC_EXCLUDE_OPTS[@]}" \
        -e "ssh -o ControlPath=\"$SSH_CONTROL_PATH\"" \
        "$TARGET/" \
        "$REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH/" 2>&1 | tee "$TEMP_LOG"
    
    # Append the itemized changes to the log file
    cat "$TEMP_LOG" >> "$LOG_FILE"
    rm -f "$TEMP_LOG"
    
    RSYNC_EXIT=$?
    if [ $RSYNC_EXIT -eq 0 ]; then
        log_message "SUCCESS: Successfully synced '$BASENAME'"
        echo "✅ Successfully synced '$BASENAME'"
    elif [ $RSYNC_EXIT -eq 23 ] || [ $RSYNC_EXIT -eq 24 ]; then
        log_message "PARTIAL: Partial transfer of '$BASENAME' (exit code: $RSYNC_EXIT)"
        echo "⚠️  Partial transfer (some files may have been skipped). Exit code: $RSYNC_EXIT"
    else
        log_message "FAILED: Failed to sync '$BASENAME' (rsync exit code: $RSYNC_EXIT)"
        echo "❌ Failed to sync '$BASENAME' (rsync exit code: $RSYNC_EXIT)"
        echo "This could be due to:"
        echo "1. Authentication issues"
        echo "2. Network problems"
        echo "3. Permission issues on remote host"
        echo "4. Disk space issues"
        
        # Check for specific permission issues in the log
        if grep -i "permission denied" "$TEMP_LOG" >/dev/null 2>&1; then
            echo "   Detected permission issues. You may not have write access to the remote directory."
            log_message "PERMISSION ISSUE DETECTED: User lacks write permissions on remote host"
        fi
    fi
done

log_message "=== Sync operation completed ==="

# Close the SSH ControlMaster connection
ssh -o ControlPath="$SSH_CONTROL_PATH" -O exit "$REMOTE_USER@$REMOTE_HOST" 2>/dev/null
log_message "SSH ControlMaster connection closed"

echo
echo "========================================"
echo "Sync complete!"
echo "Only changed or new files were transferred."
echo "Log file saved to: $LOG_FILE"
echo "========================================"
