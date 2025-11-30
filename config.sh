# config.sh - Central configuration for all scripts

# Project root - will be set by core-loader.sh if not already set
PROJECT_ROOT_DIR="${PROJECT_ROOT_DIR:-/home/ravi/code/github/htanivar/rbash}"

# Logging configuration
DEFAULT_LOG_DIR="$PROJECT_ROOT_DIR/logs"
MAX_LOG_FILES=10
LOG_RETENTION_DAYS=30

# Other global configurations
DEBUG="${DEBUG:-0}"
VERBOSE="${VERBOSE:-0}"