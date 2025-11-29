#!/bin/bash
# Enhanced core-loader.sh with better auto-detection

find_project_root() {
    local dir="$1"
    while [ "$dir" != "/" ]; do
        if [ -f "$dir/config.sh" ] || [ -f "$dir/core-loader.sh" ]; then
            echo "$dir"
            return 0
        fi
        dir="$(dirname "$dir")"
    done
    return 1
}

# Auto-detect project root if not set
if [ -z "$PROJECT_ROOT_DIR" ]; then
    # Try to find project root from current script location
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    PROJECT_ROOT_DIR="$(find_project_root "$SCRIPT_DIR")"

    if [ -z "$PROJECT_ROOT_DIR" ]; then
        # Fallback: try from current working directory
        PROJECT_ROOT_DIR="$(find_project_root "$(pwd)")"
    fi

    if [ -z "$PROJECT_ROOT_DIR" ]; then
        echo "Error: Could not determine PROJECT_ROOT_DIR" >&2
        return 1 2>/dev/null || exit 1
    fi
    export PROJECT_ROOT_DIR
fi