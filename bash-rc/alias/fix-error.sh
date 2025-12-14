#!/bin/bash
# ----
# Advanced Functions
# ----

# Git Checkout - Switch branches or restore files
unalias gc 2>/dev/null
gc() {
  local branch_name
  if [ -z "$1" ]; then
    read -p "Enter branch name: " branch_name
    # Handle read failure or empty input
    if [ -z "$branch_name" ]; then
      echo "Error: No branch name provided." >&2
      return 1
    fi
  else
    branch_name="$1"
  fi
  git checkout "$branch_name"
}
