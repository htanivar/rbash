# Validation Functions

The project provides robust validation capabilities through `functions/validation.sh`:

## Core Functions

### require_root()
Validates that the script is run as root user.

**Usage:**
```bash
require_root
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

## Integration

To use these functions in your scripts, first set `PROJECT_ROOT_DIR`:

```bash
# Set PROJECT_ROOT_DIR to the root of your project
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT_DIR="$(dirname "$SCRIPT_DIR")"
export PROJECT_ROOT_DIR

# Source the validation functions
source "$PROJECT_ROOT_DIR/functions/validation.sh"
```

See [examples/validation-functions.sh](examples/validation-functions.sh) for validation function usage examples.
