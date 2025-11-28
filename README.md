# rbash

## How to execute bash script

 put a ./ and then script name
        ./scriptName.sh

## Documentation

- [Logging Functions](docs/LOG.md)
- [Error Handling Functions](docs/ERROR.md)

## Logging Functions

The project provides robust logging capabilities through `functions/log.sh`:

### Core Functions
- [`init_logging()`](docs/LOG.md#init_logging) - Initializes the logging system by creating a timestamped log file
- [`log()`](docs/LOG.md#log) - Logs messages with timestamps and levels to both console and log file

### Specialized Functions
- [`log_info()`](docs/LOG.md#log_info) - Logs informational messages
- [`log_warn()`](docs/LOG.md#log_warn) - Logs warning messages
- [`log_error()`](docs/LOG.md#log_error) - Logs error messages
- [`log_debug()`](docs/LOG.md#log_debug) - Logs debug messages (when DEBUG=1)
- [`log_step()`](docs/LOG.md#log_step) - Logs step messages with identifiers
- [`log_command()`](docs/LOG.md#log_command) - Logs commands to a file

## Error Handling Functions

The project provides robust error handling capabilities through `functions/error.sh`:

### Core Functions
- [`error_exit()`](docs/ERROR.md#error_exit) - Exits the script with an error message and specified exit code
- [`warn()`](docs/ERROR.md#warn) - Logs a warning message
- [`set_strict_mode()`](docs/ERROR.md#set_strict_mode) - Enables strict error handling in the script
- [`setup_cleanup_trap()`](docs/ERROR.md#setup_cleanup_trap) - Sets up a trap to run a cleanup function on script exit

To use these functions in your scripts, first set `PROJECT_ROOT_DIR`:

```bash
# Set PROJECT_ROOT_DIR to the root of your project
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT_DIR="$(dirname "$SCRIPT_DIR")"
export PROJECT_ROOT_DIR

# Source the logging functions
source "$PROJECT_ROOT_DIR/functions/log.sh"

# Source the error handling functions
source "$PROJECT_ROOT_DIR/functions/error.sh"
```

See [examples/log-functions.sh](examples/log-functions.sh) for logging usage examples.
