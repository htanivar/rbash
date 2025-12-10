# rbash

## How to execute bash script

put a ./ and then script name
./scriptName.sh

## Documentation

- [Logging Functions](docs/LOG.md)
- [Error Handling Functions](docs/ERROR.md)
- [Validation Functions](docs/VALIDATION.md)
- [Input Functions](docs/INPUT.md)
- [Info Functions](docs/INFO.md)
- [Key & Cert Functions](docs/KEY_CERT.md)
- [Path Functions](docs/PATH.md)
- [OS Operation Functions](docs/OS_OPS.md)
- [Network Functions](docs/NETWORK.md)
- [SCP Operations Functions](docs/scp-ops.md)
- [Utility Functions](docs/UTILS.md)

## Logging Functions

The project provides robust logging capabilities through `functions/log.sh`:

- [`init_logging()`](docs/LOG.md#init_logging) - Initializes the logging system by creating a timestamped log file
- [`log()`](docs/LOG.md#log) - Logs messages with timestamps and levels to both console and log file
- [`log_info()`](docs/LOG.md#log_info) - Logs informational messages
- [`log_warn()`](docs/LOG.md#log_warn) - Logs warning messages
- [`log_error()`](docs/LOG.md#log_error) - Logs error messages
- [`log_debug()`](docs/LOG.md#log_debug) - Logs debug messages (when DEBUG=1)
- [`log_step()`](docs/LOG.md#log_step) - Logs step messages with identifiers
- [`log_command()`](docs/LOG.md#log_command) - Logs commands to a file

See [examples/log-functions.sh](examples/log-functions.sh) for logging usage examples.

## Error Handling Functions

The project provides robust error handling capabilities through `functions/error.sh`:

- [`error_exit()`](docs/ERROR.md#error_exit) - Exits the script with an error message and specified exit code
- [`warn()`](docs/ERROR.md#warn) - Logs a warning message
- [`set_strict_mode()`](docs/ERROR.md#set_strict_mode) - Enables strict error handling in the script
- [`setup_cleanup_trap()`](docs/ERROR.md#setup_cleanup_trap) - Sets up a trap to run a cleanup function on script exit

To use these functions in your scripts, first set `PROJECT_ROOT_DIR`:

See [examples/error-functions.sh](examples/error-functions.sh) for error function usage examples.

## Validation Functions

The project provides robust validation capabilities through `functions/validation.sh`:

- [`must_be_root()`](docs/VALIDATION.md#must_be_root) - Checks if the user is root
- [`require_sudo()`](docs/VALIDATION.md#require_sudo) - Validates that the script is run as root user
- [`require_non_root()`](docs/VALIDATION.md#require_non_root) - Validates that the script is NOT run as root user
- [`require_var()`](docs/VALIDATION.md#require_var) - Validates that a required variable is set and not empty
- [`require_command()`](docs/VALIDATION.md#require_command) - Validates that a required command is available in the
  system
- [`require_file()`](docs/VALIDATION.md#require_file) - Validates that a required file exists
- [`require_directory()`](docs/VALIDATION.md#require_directory) - Validates that a required directory exists
- [`check_file_permissions()`](docs/VALIDATION.md#check_file_permissions) - Validates file permissions (read, write,
  execute)
- [`check_distribution()`](docs/VALIDATION.md#check_distribution) - Checks if the current distribution is in the
  supported
  list

To use these functions in your scripts, first set `PROJECT_ROOT_DIR`:

See [examples/validation-functions.sh](examples/validation-functions.sh) for validation function usage examples.

## Input Functions

The project provides robust input handling capabilities through `functions/input.sh`:

- [`prompt_input()`](docs/INPUT.md#prompt_input) - Prompts for user input with validation, defaults, and secret input
  support
- [`confirm_action()`](docs/INPUT.md#confirm_action) - Confirms actions with the user with customizable defaults

To use these functions in your scripts, first set `PROJECT_ROOT_DIR`:

See [examples/input-functions.sh](examples/input-functions.sh) for input function usage examples.

## Info Functions

The project provides system utility capabilities through `functions/info.sh`:

- [`get_current_user()`](docs/INFO.md#get_current_user) - Gets the current non-root user (works with sudo)
- [`get_distribution()`](docs/INFO.md#get_distribution) - Gets the distribution information

To use these functions in your scripts, first set `PROJECT_ROOT_DIR`:

See [examples/info-functions.sh](examples/info-functions.sh) for path function usage examples.

## Key & Cert Functions

The project provides system utility capabilities through `functions/key_cert.sh`:

- [`generate_ssh_key()`](docs/INFO.md#generate_ssh_key) - Generates SSH key pairs

To use these functions in your scripts, first set `PROJECT_ROOT_DIR`:

See [examples/key_cert-functions.sh](examples/key_cert-functions.sh) for path function usage examples.

## Path Functions

The project provides system utility capabilities through `functions/path.sh`:

- [`add_to_path()`](docs/PATH.md#add_to_path) - Adds directories to the PATH environment variable
- [`create_path_link()`](docs/PATH.md#create_path_link) - Creates symbolic links in system paths

To use these functions in your scripts, first set `PROJECT_ROOT_DIR`:

See [examples/path-functions.sh](examples/path-functions.sh) for path function usage examples.

## OS Operation Functions

The project provides utility capabilities through `functions/os_ops.sh`:

- [`create_directory()`](docs/UTILS.md#create_directory) - Creates directory with proper ownership and permissions
- [`backup_file()`](docs/UTILS.md#backup_file) - Backs up file with timestamp

See [examples/os_ops-functions.sh](examples/os_ops-functions.sh) for utility function usage examples.

## Network Functions

The project provides utility capabilities through `functions/network.sh`:

- [`check_port()`](docs/UTILS.md#check_port) - Checks if port is available

See [examples/network-functions.sh](examples/network-functions.sh) for utility function usage examples.

## SCP Operations Functions

The project provides SCP (Secure Copy Protocol) operations capabilities through `functions/scp_ops.sh`:

- [`copy_remote_file()`](docs/scp-ops.md#copy_remote_file) - Copy file from remote host to local using scp
- [`copy_to_remote()`](docs/scp-ops.md#copy_to_remote) - Copy file from local to remote host using scp
- [`copy_remote_directory()`](docs/scp-ops.md#copy_remote_directory) - Copy directory recursively from remote to local
- [`copy_directory_to_remote()`](docs/scp-ops.md#copy_directory_to_remote) - Copy directory recursively from local to remote
- [`test_ssh_connection()`](docs/scp-ops.md#test_ssh_connection) - Test SSH connection to remote host

See [examples/scp_ops-functions.sh](examples/scp_ops-functions.sh) for SCP operations function usage examples.

## Utility Functions

The project provides utility capabilities through `functions/utils.sh`:

- [`generate_random_string()`](docs/UTILS.md#generate_random_string) - Generates random string

See [examples/utils-functions.sh](examples/utils-functions.sh) for utility function usage examples.

# ROOT only functions

## System Management Functions

The project provides system management capabilities through `functions/root/system.sh`:

- [`set_hostname()`](docs/root/SYSTEM.md#set_hostname) - Sets the system hostname and updates /etc/hosts
- [`set_fqdn()`](docs/root/SYSTEM.md#set_fqdn) - Sets the system FQDN and hostname
- [`add_swap_memory()`](docs/root/SYSTEM.md#add_swap_memory) - Adds swap memory with specified size
- [`remove_swap_memory()`](docs/root/SYSTEM.md#remove_swap_memory) - Removes swap memory and cleans up
- [`update_system()`](docs/root/SYSTEM.md#update_system) - Updates system packages using the detected package manager
- [`clean_system()`](docs/root/SYSTEM.md#clean_system) - Cleans system packages and cache
- [`detect_package_manager()`](docs/root/SYSTEM.md#detect_package_manager) - Detects the system's package manager

See [examples/root/system-functions.sh](examples/root/system-functions.sh) for system management function usage examples.

## User Management Functions

The project provides user management capabilities through `functions/root/user.sh`:

- [`create_user()`](docs/root/USER.md#create_user) - Creates a new user with specified options
- [`create_admin_user()`](docs/root/USER.md#create_admin_user) - Creates a new admin user with sudo access
- [`delete_user()`](docs/root/USER.md#delete_user) - Deletes a user account
- [`add_user_to_group()`](docs/root/USER.md#add_user_to_group) - Adds a user to a group
- [`remove_user_from_group()`](docs/root/USER.md#remove_user_from_group) - Removes a user from a group
- [`setup_ssh_key()`](docs/root/USER.md#setup_ssh_key) - Sets up an SSH key for a user
- [`generate_ssh_key()`](docs/root/USER.md#generate_ssh_key) - Generates an SSH key pair for a user

See [examples/root/user-functions.sh](examples/root/user-functions.sh) for user management function usage examples.
