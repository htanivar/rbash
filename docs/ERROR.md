# Error Handling Functions

The project provides robust error handling capabilities through `functions/error.sh`:

## Core Functions

### `error_exit()`
Exits the script with an error message and specified exit code.

**Usage:**
```bash
error_exit "Error message" [exit_code]
```

**Parameters:**
- `message`: The error message to display (default: "Unknown error")
- `exit_code`: The exit code to use (default: 1)

**Behavior:**
- Logs the error message using `log_error`
- Logs the exit code
- Exits the script with the specified code

### `warn()`
Logs a warning message.

**Usage:**
```bash
warn "Warning message"
```

**Parameters:**
- `message`: The warning message to display

**Behavior:**
- Logs the warning message using `log_warn`

### `set_strict_mode()`
Enables strict error handling in the script.

**Usage:**
```bash
set_strict_mode
```

**Behavior:**
- Sets `set -euo pipefail` for strict error handling
- Logs debug message about enabling strict mode

### `setup_cleanup_trap()`
Sets up a trap to run a cleanup function on script exit.

**Usage:**
```bash
setup_cleanup_trap "cleanup_function"
```

**Parameters:**
- `cleanup_function`: The name of the function to call on exit

**Behavior:**
- Sets up traps for EXIT, INT, and TERM signals
- Logs debug message about setting the cleanup trap

## Usage Example

```bash
#!/bin/bash

# Set up project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT_DIR="$(dirname "$SCRIPT_DIR")"
export PROJECT_ROOT_DIR

# Source the error handling functions
source "$PROJECT_ROOT_DIR/functions/error.sh"

# Initialize logging
source "$PROJECT_ROOT_DIR/functions/log.sh"

# Set strict mode
set_strict_mode

# Define cleanup function
cleanup() {
    log_info "Cleaning up resources..."
    # Add cleanup logic here
}

# Setup cleanup trap
setup_cleanup_trap cleanup

# Example usage
warn "This is a warning"
error_exit "Fatal error occurred" 1
```
