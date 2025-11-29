#!/bin/bash
# utils.sh - utils utility functions for bash scripts

# =============================================================================
# UTILITY FUNCTIONS
# =============================================================================


# Generate random string
generate_random_string() {
    local length="${1:-16}"
    local charset="${2:-A-Za-z0-9}"

    tr -dc "$charset" < /dev/urandom | head -c "$length"
}

