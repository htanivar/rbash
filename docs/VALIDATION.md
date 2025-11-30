# Validation Functions

The project provides robust validation capabilities through `functions/validation.sh`:

## Table of Contents
- [require_sudo](#require_sudo)
- [require_non_root](#require_non_root)
- [require_var](#require_var)
- [require_command](#require_command)
- [require_file](#require_file)
- [require_directory](#require_directory)
- [check_file_permissions](#check_file_permissions)
- [check_distribution](#check_distribution)

## Core Functions

### require_sudo()

Validates that the script is run as root user.

**Usage:**

```bash
require_sudo
```

### require_non_root()

Validates that the script is NOT run as root user.

**Usage:**

```bash
require_non_root
```

### require_var()

Validates that a required variable is set and not empty.

**Usage:**

```bash
require_var "VARIABLE_NAME"
```

### require_command()

Validates that a required command is available in the system.

**Usage:**

```bash
require_command "command_name"
```

### require_file()

Validates that a required file exists.

**Usage:**

```bash
require_file "/path/to/file"
```

### require_directory()

Validates that a required directory exists.

**Usage:**

```bash
require_directory "/path/to/directory"
```

### check_file_permissions()

Validates file permissions (read, write, execute).

**Usage:**

```bash
check_file_permissions "/path/to/file" "rwx"
```

### check_distribution

Checks if the current distribution is in the list of supported distributions.

**Usage:**

```bash
# Check against specific distributions
check_distribution "ubuntu debian centos"

# Use in conditional logic
if (check_distribution "ubuntu debian" >/dev/null 2>&1); then
    echo "This is a Debian-based system"
fi
```

**Description:**
This function compares the current distribution (from `get_distribution()`) against a space-separated list of supported
distributions. If the current distribution is found in the list, it returns 0 (success). If not found, it calls
`error_exit` to terminate the script with an error message.

**Parameters:**

- `$1`: Space-separated list of supported distribution names

**Returns:**

- 0 if distribution is supported
- Calls `error_exit` if distribution is not supported

**Note:** When using in conditionals, run in a subshell to prevent the entire script from exiting on unsupported
distributions.

See [examples/validation-functions.sh](examples/validation-functions.sh) for validation function usage examples.
