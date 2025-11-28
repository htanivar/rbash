#!/bin/bash

# Get the absolute path to this script's directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Source the configuration
source "$SCRIPT_DIR/../../config/config.sh"
# Source the log functions
source "$SCRIPT_DIR/../../functions/log.sh"

# Initialize logging using the DEFAULT_LOG_DIR from config.sh
init_logging "log-functions.sh"

log "Attempting to log via function"
log "INFO: Ravi Jaganathan is testing"
