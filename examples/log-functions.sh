#!/bin/bash

# Example script demonstrating the usage of specialized logging functions
# Set PROJECT_ROOT_DIR before sourcing log.sh
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT_DIR="$(dirname "$SCRIPT_DIR")"
export PROJECT_ROOT_DIR

# Source the logging functions
source "$PROJECT_ROOT_DIR/functions/log.sh"

# Initialize logging
init_logging "example_script"

# Demonstrate basic log function
log "This is a basic log message"

# Demonstrate specialized logging functions
log_info "This is an informational message"
log_warn "This is a warning message"
log_error "This is an error message"

# Demonstrate debug logging (only when DEBUG=1)
DEBUG=1
log_debug "This debug message will appear because DEBUG=1"

# Turn off debug
DEBUG=0
log_debug "This debug message won't appear because DEBUG=0"

# Demonstrate step logging
log_step "SETUP" "Starting the setup process"
log_step "PROCESS" "Processing data"
log_step "CLEANUP" "Cleaning up temporary files"

# Demonstrate command logging
log_command "ls -la" "example_commands.log"
log_command "date" "example_commands.log"

# Show the log file location
log_info "Check the log file at: $DEFAULT_LOG_FILE"
log_info "Check the command log at: example_commands.log"
