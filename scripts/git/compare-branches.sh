#!/usr/bin/env bash

set -euo pipefail

SOURCE_BRANCH="${1:-}"
TARGET_BRANCH="${2:-}"

if [ -z "$SOURCE_BRANCH" ] || [ -z "$TARGET_BRANCH" ]; then
  echo "Usage: $0 <source-branch> <target-branch>" >&2
  exit 1
fi

# Ensure we are inside a git repo
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || {
  echo "Error: Not inside a git repository" >&2
  exit 1
}

# Fetch latest refs (safe even for local-only usage)
git fetch --all --quiet

echo "Comparing content:"
echo "  Source : $SOURCE_BRANCH"
echo "  Target : $TARGET_BRANCH"
echo

# Show files that differ
echo "Files with differences:"
git diff --name-only "$TARGET_BRANCH..$SOURCE_BRANCH"
echo

# Show actual missing changes
echo "===== Missing code in target branch ====="
git diff "$TARGET_BRANCH..$SOURCE_BRANCH"
