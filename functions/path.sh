#!/bin/bash
# path.sh - system utility functions for bash scripts

# =============================================================================
# PATH FUNCTIONS
# =============================================================================
# Add directory to PATH
add_to_path() {
    local directory="$1"
    local user="${2:-$(whoami)}"
    local profile_file="${3:-$HOME/.bashrc}"

    log_step "PATH" "Adding directory to PATH: $directory"

    # Check if directory exists
    if [ ! -d "$directory" ]; then
        log_warn "Directory does not exist: $directory"
        return 1
    fi

    # Check if already in PATH
    if [[ ":$PATH:" == *":$directory:"* ]]; then
        log_debug "Directory already in PATH: $directory"
        return 0
    fi

    # Add to PATH in current session
    export PATH="$directory:$PATH"

    # Add to profile file for persistence
    echo "export PATH=\"$directory:\$PATH\"" >> "$profile_file"

    log_info "Directory added to PATH: $directory"
}

# Create symbolic link in PATH
create_path_link() {
    local target="$1"
    local link_name="$2"
    local bin_dir="${3:-$HOME/.local/bin}"

    log_step "LINK" "Creating symbolic link: $link_name -> $target"

    # Ensure target exists
    if [ ! -e "$target" ]; then
        log_error "Target does not exist: $target"
        return 1
    fi

    # Create bin directory if it doesn't exist
    if [ ! -d "$bin_dir" ]; then
        mkdir -p "$bin_dir" || {
            log_error "Failed to create directory: $bin_dir"
            return 1
        }
        log_debug "Created bin directory: $bin_dir"
    else
        log_debug "Bin directory already exists: $bin_dir"
    fi

    # Use just the basename for the link
    local link_basename=$(basename "$link_name")
    local link_path="$bin_dir/$link_basename"

    log_debug "Link path will be: $link_path"

    # Remove existing link if it exists
    if [ -L "$link_path" ]; then
        rm "$link_path"
        log_debug "Existing symbolic link removed: $link_path"
    elif [ -e "$link_path" ]; then
        log_error "A regular file exists at $link_path. Please remove it manually."
        return 1
    fi

    # Create new symbolic link
    if ln -s "$target" "$link_path"; then
        log_info "Symbolic link created: $link_basename -> $target"
    else
        log_error "Failed to create symbolic link: $link_path -> $target"
        return 1
    fi

    # Make sure bin directory is in PATH
    add_to_path "$bin_dir"

    log_info "Symbolic link created: $link_basename -> $target"
}
