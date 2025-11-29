#!/bin/bash
# input.sh - input utility functions for bash scripts

# =============================================================================
# INPUT FUNCTIONS
# =============================================================================

# Prompt for user input with validation
prompt_input() {
    local prompt_text="$1"
    local var_name="$2"
    local default_value="${3:-}"
    local is_required="${4:-true}"
    local is_secret="${5:-false}"
    
    local input_value=""
    
    while true; do
        if [ "$is_secret" = "true" ]; then
            read -s -p "$prompt_text: " input_value
            echo  # New line after secret input
        else
            if [ -n "$default_value" ]; then
                read -p "$prompt_text [$default_value]: " input_value
                input_value="${input_value:-$default_value}"
            else
                read -p "$prompt_text: " input_value
            fi
        fi
        
        if [ -z "$input_value" ] && [ "$is_required" = "true" ]; then
            echo "Input is required. Please try again." >&2
            continue
        fi
        
        break
    done
    
    # Set the variable dynamically
    eval "$var_name='$input_value'"
    # If log_debug function exists, use it, otherwise silently set the variable
    if command -v log_debug >/dev/null 2>&1; then
        log_debug "User input captured for: $var_name"
    fi
}

# Confirm action with user
confirm_action() {
    local message="$1"
    local default="${2:-n}"
    local response
    
    if [ "$default" = "y" ]; then
        read -p "$message (Y/n): " response
        response=${response:-y}
    else
        read -p "$message (y/N): " response
        response=${response:-n}
    fi
    
    case "$response" in
        [Yy]|[Yy][Ee][Ss]) 
            # If log_debug function exists, use it
            if command -v log_debug >/dev/null 2>&1; then
                log_debug "User confirmed: $message"
            fi
            return 0 
            ;;
        *) 
            # If log_debug function exists, use it
            if command -v log_debug >/dev/null 2>&1; then
                log_debug "User declined: $message"
            fi
            return 1 
            ;;
    esac
}
