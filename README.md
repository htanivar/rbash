# rbash

## How to execute bash script

 put a ./ and then script name
        ./scriptName.sh

## Documentation

- [Logging Functions](docs/LOG.md)

## Logging Functions

The project provides robust logging capabilities through `functions/log.sh`:

### init_logging()
Initializes the logging system by creating a timestamped log file. It automatically handles directory creation and fallback to `/tmp` if needed.

### log()
Logs messages with timestamps and levels to both console and log file. Supports different log levels like INFO, WARNING, ERROR.

To use these functions in your scripts:
```bash
source "$(dirname "$0")/functions/log.sh"
```
