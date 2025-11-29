# rbash

## How to execute bash script

put a ./ and then script name
./scriptName.sh

## Documentation

- [Logging Functions](docs/LOG.md)
- [Error Handling Functions](docs/ERROR.md)
- [Validation Functions](docs/VALIDATION.md)
- [Input Functions](docs/INPUT.md)
- [System Functions](docs/SYSTEM.md)
- [Key & Cert Functions](docs/KEY_CERT.md)
- [Path Functions](docs/PATH.md)
- [Utility Functions](docs/UTILS.md)

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

See [examples/log-functions.sh](examples/log-functions.sh) for logging usage examples.

## Error Handling Functions

The project provides robust error handling capabilities through `functions/error.sh`:

### Core Functions

- [`error_exit()`](docs/ERROR.md#error_exit) - Exits the script with an error message and specified exit code
- [`warn()`](docs/ERROR.md#warn) - Logs a warning message
- [`set_strict_mode()`](docs/ERROR.md#set_strict_mode) - Enables strict error handling in the script
- [`setup_cleanup_trap()`](docs/ERROR.md#setup_cleanup_trap) - Sets up a trap to run a cleanup function on script exit

To use these functions in your scripts, first set `PROJECT_ROOT_DIR`:

See [examples/error-functions.sh](examples/error-functions.sh) for error function usage examples.

## Validation Functions

The project provides robust validation capabilities through `functions/validation.sh`:

### Core Functions

- [`require_root()`](docs/VALIDATION.md#require_root) - Validates that the script is run as root user
- [`require_non_root()`](docs/VALIDATION.md#require_non_root) - Validates that the script is NOT run as root user
- [`require_var()`](docs/VALIDATION.md#require_var) - Validates that a required variable is set and not empty
- [`require_command()`](docs/VALIDATION.md#require_command) - Validates that a required command is available in the
  system
- [`require_file()`](docs/VALIDATION.md#require_file) - Validates that a required file exists
- [`require_directory()`](docs/VALIDATION.md#require_directory) - Validates that a required directory exists
- [`check_file_permissions()`](docs/VALIDATION.md#check_file_permissions) - Validates file permissions (read, write,
  execute)

To use these functions in your scripts, first set `PROJECT_ROOT_DIR`:

See [examples/validation-functions.sh](examples/validation-functions.sh) for validation function usage examples.

## Input Functions

The project provides robust input handling capabilities through `functions/input.sh`:

### Core Functions

- [`prompt_input()`](docs/INPUT.md#prompt_input) - Prompts for user input with validation, defaults, and secret input
  support
- [`confirm_action()`](docs/INPUT.md#confirm_action) - Confirms actions with the user with customizable defaults

To use these functions in your scripts, first set `PROJECT_ROOT_DIR`:

See [examples/input-functions.sh](examples/input-functions.sh) for input function usage examples.

## System Functions

The project provides system utility capabilities through `functions/system.sh`:

### Core Functions

- [`get_current_user()`](docs/SYSTEM.md#get_current_user) - Gets the current non-root user (works with sudo)
- [`get_distribution()`](docs/SYSTEM.md#get_distribution) - Gets the distribution information
- [`check_distribution()`](docs/SYSTEM.md#check_distribution) - Checks if the current distribution is in the supported
  list

To use these functions in your scripts, first set `PROJECT_ROOT_DIR`:

See [examples/system-functions.sh](examples/system-functions.sh) for path function usage examples.

## Key & Cert Functions

The project provides system utility capabilities through `functions/key_cert.sh`:

### Core Functions

- [`generate_ssh_key()`](docs/SYSTEM.md#generate_ssh_key) - Generates SSH key pairs

To use these functions in your scripts, first set `PROJECT_ROOT_DIR`:

See [examples/key_cert-functions.sh](examples/key_cert-functions.sh) for path function usage examples.

## Path Functions

The project provides system utility capabilities through `functions/path.sh`:

### Core Functions

- [`add_to_path()`](docs/PATH.md#add_to_path) - Adds directories to the PATH environment variable
- [`create_path_link()`](docs/PATH.md#create_path_link) - Creates symbolic links in system paths

To use these functions in your scripts, first set `PROJECT_ROOT_DIR`:

See [examples/path-functions.sh](examples/path-functions.sh) for path function usage examples.

## Utility Functions

The project provides utility capabilities through `functions/utils.sh`:

### Core Functions

- [`create_directory()`](docs/UTILS.md#create_directory) - Creates directory with proper ownership and permissions
- [`backup_file()`](docs/UTILS.md#backup_file) - Backs up file with timestamp
- [`generate_random_string()`](docs/UTILS.md#generate_random_string) - Generates random string
- [`check_port()`](docs/UTILS.md#check_port) - Checks if port is available

To use these functions in your scripts, first set `PROJECT_ROOT_DIR`:

See [examples/utils-functions.sh](examples/utils-functions.sh) for utility function usage examples.
