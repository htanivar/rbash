# Logging Functions

This document provides detailed usage examples for the logging functions available in the project.

## Prerequisites

Before using these functions, ensure:
- `PROJECT_ROOT_DIR` is set in `config/config.sh` to point to your project root
- `config/config.sh` exists and defines `$DEFAULT_LOG_DIR` (defaults to `$PROJECT_ROOT_DIR/logs`)
- The script sourcing `log.sh` must be run from within the project structure where `PROJECT_ROOT_DIR` is accessible

**Note:** Log files in the `logs/` directory are ignored by git (see `.gitignore`)

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

3. In a complete script example:
```bash
#!/bin/bash
source "$(dirname "$0")/functions/log.sh"

init_logging "data_processor.sh"

log "Starting data processing job"
# ... processing logic ...
if [ $? -eq 0 ]; then
    log "Data processing completed successfully"
else
    log "Data processing failed" "ERROR"
    exit 1
fi
log "Job finished" "INFO"
```

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
