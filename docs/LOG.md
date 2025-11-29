# Logging Functions

This document provides detailed usage examples for the logging functions available in the project.

## Table of Contents
- [init_logging](#init_logging)
- [log](#log)
- [log_info](#log_info)
- [log_warn](#log_warn)
- [log_error](#log_error)
- [log_debug](#log_debug)
- [log_step](#log_step)
- [log_command](#log_command)

## Prerequisites

Before using these functions, ensure:
- `PROJECT_ROOT_DIR` environment variable is set to point to your project root
- `config/config.sh` exists and defines `$DEFAULT_LOG_DIR` (defaults to `$PROJECT_ROOT_DIR/logs`)

**Note:** Log files in the `logs/` directory are ignored by git (see `.gitignore`)

## Setting up PROJECT_ROOT_DIR

To use the logging functions in your scripts, you must set `PROJECT_ROOT_DIR` before sourcing `log.sh`:

```bash
#!/bin/bash
# Set PROJECT_ROOT_DIR to the root of your project
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT_DIR="$(dirname "$SCRIPT_DIR")"
export PROJECT_ROOT_DIR

# Source the logging functions
source "$PROJECT_ROOT_DIR/functions/log.sh"
```

## Function Documentation

### init_logging()

Initializes the logging system by creating a timestamped log file.

**Syntax:**
```bash
init_logging [script_name] [log_dir]
```

**Parameters:**
- `script_name` (optional): Name of the script. Defaults to the current script's basename
- `log_dir` (optional): Directory to store logs. Defaults to `$DEFAULT_LOG_DIR`

**Examples:**

1. Basic usage with default parameters:
```bash
#!/bin/bash
source "$(dirname "$0")/functions/log.sh"

init_logging
log "This will create a log file in the default logs directory"
```

2. Custom script name and log directory:
```bash
#!/bin/bash
source "$(dirname "$0")/functions/log.sh"

init_logging "my_custom_script" "/var/log/myapp"
log "This will create: /var/log/myapp/my_custom_script_YYYYMMDD_HHMMSS.log"
```

3. Handling directory creation issues:
```bash
#!/bin/bash
source "$(dirname "$0")/functions/log.sh"

# If the specified directory can't be created, it falls back to /tmp
init_logging "secure_script" "/root/logs"
log "If /root/logs can't be created, log file will be in /tmp"
```

### log()

Logs messages with timestamp and level to both console and log file.

**Syntax:**
```bash
log "message" [level]
```

**Parameters:**
- `message`: The message text to log
- `level` (optional): Log level (INFO, WARNING, ERROR, etc.). Defaults to "INFO"

**Examples:**

1. Basic logging:
```bash
log "Process started successfully"
# Output: [2023-11-28 10:30:45] [INFO] Process started successfully
```

2. Different log levels:
```bash
log "User login successful" "INFO"
log "Disk space running low" "WARNING"
log "Database connection failed" "ERROR"
```

### Specialized Logging Functions

#### log_info()
Logs informational messages. Equivalent to `log "message" "INFO"`.

**Syntax:**
```bash
log_info "message"
```

**Example:**
```bash
log_info "Application started successfully"
```

#### log_warn()
Logs warning messages. Equivalent to `log "message" "WARN"`.

**Syntax:**
```bash
log_warn "message"
```

**Example:**
```bash
log_warn "Disk space is running low"
```

#### log_error()
Logs error messages. Equivalent to `log "message" "ERROR"`.

**Syntax:**
```bash
log_error "message"
```

**Example:**
```bash
log_error "Failed to connect to database"
```

#### log_debug()
Logs debug messages only when `DEBUG=1` environment variable is set.

**Syntax:**
```bash
log_debug "message"
```

**Example:**
```bash
DEBUG=1
log_debug "Debug information for troubleshooting"
```

#### log_step()
Logs step messages with a specific step identifier.

**Syntax:**
```bash
log_step "step_name" "message"
```

**Example:**
```bash
log_step "SETUP" "Initializing database connection"
# Output: [timestamp] [STEP] [SETUP] Initializing database connection
```

#### log_command()
Logs commands to a specified file and also logs the action.

**Syntax:**
```bash
log_command "command" [log_file]
```

**Parameters:**
- `command`: The command to log
- `log_file` (optional): File to log the command to (defaults to "command_log.txt")

**Example:**
```bash
log_command "rm -rf /tmp/cache" "cleanup_commands.log"
```

### Complete Example Script

See [examples/log-functions.sh](../examples/log-functions.sh) for a complete demonstration of all logging functions.

## Best Practices

1. Always call `init_logging` at the beginning of your script
2. Use appropriate log levels to categorize messages
3. Include meaningful context in log messages
4. The logging system automatically handles:
   - Directory creation
   - Fallback to /tmp if primary location is unavailable
   - Timestamp formatting
   - Dual output (console + file)

## Source
These functions are defined in `functions/log.sh`.
