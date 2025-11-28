#!/bin/bash

# Example script demonstrating error handling functions
# Set up project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT_DIR="$(dirname "$SCRIPT_DIR")"
export PROJECT_ROOT_DIR

# Source the error handling and logging functions
source "$PROJECT_ROOT_DIR/functions/log.sh"
source "$PROJECT_ROOT_DIR/functions/error.sh"

# Initialize logging
init_logging "error-functions-example"

# Set strict mode
set_strict_mode

# Define a cleanup function
cleanup() {
    log_info "Running cleanup tasks..."
    # Simulate some cleanup work
    sleep 1
    log_info "Cleanup completed"
}

# Setup cleanup trap
setup_cleanup_trap cleanup

# Function to demonstrate various scenarios
demonstrate_error_functions() {
    log_step "1" "Starting error functions demonstration"
    
    # Example 1: Using warn() for non-critical issues
    warn "This is a warning message about a potential issue"
    
    # Example 2: Simulate a function that might fail
    simulate_operation() {
        local should_fail="$1"
        if [ "$should_fail" = "true" ]; then
            error_exit "Operation failed intentionally" 2
        else
            log_info "Operation completed successfully"
        fi
    }
    
    log_step "2" "Testing successful operation"
    simulate_operation "false"
    
    log_step "3" "Testing failing operation (this will exit the script)"
    simulate_operation "true"
    
    # This line won't be reached if the above operation fails
    log_info "This message won't appear if the previous operation failed"
}

# Main execution
main() {
    log_info "Starting error functions example script"
    
    # Call the demonstration function
    demonstrate_error_functions
    
    log_info "Script completed successfully"
}

# Run the main function
main
