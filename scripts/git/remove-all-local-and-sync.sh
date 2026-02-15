#!/usr/bin/env bash

# Script: remove-all-local-and-sync.sh
# Description: Remove all local branches, uncommitted changes, staged changes,
#              and reset the current branch to match the remote, then sync.
# Usage: Run from within a git repository.

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored messages
info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if we are inside a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    error "Not a git repository. Exiting."
    exit 1
fi

# Confirm with the user
echo "This script will perform the following actions:"
echo "1. Reset the current branch to match the remote (hard reset)."
echo "2. Remove all staged and unstaged changes (clean -fd)."
echo "3. Delete all local branches except the current one."
echo "4. Fetch all remote branches."
echo "5. Prune remote-tracking branches that no longer exist on remote."
echo ""
echo -n "Are you sure you want to continue? (y/N): "
read -r response
if [[ ! "$response" =~ ^[Yy]$ ]]; then
    info "Operation cancelled."
    exit 0
fi

# Get current branch
CURRENT_BRANCH=$(git branch --show-current)
if [[ -z "$CURRENT_BRANCH" ]]; then
    error "Unable to determine current branch. Are you in detached HEAD?"
    exit 1
fi

info "Current branch is: $CURRENT_BRANCH"

# Step 1: Hard reset to remote
info "Resetting $CURRENT_BRANCH to match remote..."
git fetch origin "$CURRENT_BRANCH"
if git rev-parse --verify "origin/$CURRENT_BRANCH" > /dev/null 2>&1; then
    git reset --hard "origin/$CURRENT_BRANCH"
else
    warn "Remote branch origin/$CURRENT_BRANCH does not exist. Skipping reset."
fi

# Step 2: Clean working directory and staged changes
info "Cleaning working directory..."
git clean -fd
git restore --staged .
git restore .

# Step 3: Delete all local branches except current
info "Deleting all local branches except $CURRENT_BRANCH..."
for branch in $(git branch --format='%(refname:short)'); do
    if [[ "$branch" != "$CURRENT_BRANCH" ]]; then
        if git show-ref --verify --quiet "refs/heads/$branch"; then
            git branch -D "$branch"
            info "Deleted local branch: $branch"
        fi
    fi
done

# Step 4: Fetch all remotes
info "Fetching all remotes..."
git fetch --all

# Step 5: Prune remote-tracking branches
info "Pruning remote-tracking branches..."
git remote prune origin

info "Sync completed successfully."
info "Current branch: $CURRENT_BRANCH"
info "All local changes and branches (except current) have been removed."
info "Repository is now in sync with remote."
