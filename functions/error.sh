#!/bin/bash

# =============================================================================
# ERROR HANDLING
# =============================================================================

# Error exit function with logging
error_exit() {
    local message="${1:-Unknown error}"
    local exit_code="${2:-1}"
    log_error "$message"
    log_error "Script exiting with code $exit_code"
    exit "$exit_code"
}

# Warning function
warn() {
    local message="$1"
    log_warn "$message"
}

# Set strict error handling
set_strict_mode() {
    set -euo pipefail
    log_debug "Strict mode enabled (set -euo pipefail)"
}

# Trap function for cleanup on script exit
setup_cleanup_trap() {
    local cleanup_function="$1"
    trap "$cleanup_function" EXIT INT TERM
    log_debug "Cleanup trap set: $cleanup_function"
}
