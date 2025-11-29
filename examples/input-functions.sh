#!/bin/bash

# Example script demonstrating the usage of specialized logging functions
# Set PROJECT_ROOT_DIR before sourcing log.sh
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT_DIR="$(dirname "$SCRIPT_DIR")"
export PROJECT_ROOT_DIR

# Source the functions
source "$PROJECT_ROOT_DIR/functions/log.sh"
source "$PROJECT_ROOT_DIR/functions/error.sh"
source "$PROJECT_ROOT_DIR/functions/validation.sh"
source "$PROJECT_ROOT_DIR/functions/input.sh"

# input-functions.sh - Examples for using input utility functions
# This file demonstrates how to use the input functions from functions/input.sh


echo "=== Input Functions Examples ==="
echo

# Example 1: Basic required input
echo "1. Basic required input:"
prompt_input "Enter your name" "user_name"
echo "Hello, $user_name!"
echo

# Example 2: Input with default value
echo "2. Input with default value:"
prompt_input "Enter your favorite color" "favorite_color" "blue"
echo "Your favorite color is: $favorite_color"
echo

# Example 3: Optional input
echo "3. Optional input:"
prompt_input "Enter your nickname (optional)" "nickname" "" "false"
if [ -n "$nickname" ]; then
    echo "Your nickname is: $nickname"
else
    echo "No nickname provided"
fi
echo

# Example 4: Secret input (for passwords)
echo "4. Secret input (password):"
prompt_input "Enter your password" "password" "" "true" "true"
echo "Password set (but not shown for security)"
echo

# Example 5: Confirmation
echo "5. Confirmation example:"
if confirm_action "Do you want to proceed?"; then
    echo "User chose to proceed"
else
    echo "User chose to cancel"
fi
echo

# Example 6: Confirmation with default 'yes'
echo "6. Confirmation with default 'yes':"
if confirm_action "Do you want to continue?" "y"; then
    echo "Continuing..."
else
    echo "Stopping..."
fi
echo

# Example 7: Using multiple inputs together
echo "7. Multiple inputs example:"
prompt_input "Enter database host" "db_host" "localhost"
prompt_input "Enter database port" "db_port" "5432"
prompt_input "Enter database username" "db_user" "" "true"
prompt_input "Enter database password" "db_pass" "" "true" "true"

echo "Database configuration:"
echo "  Host: $db_host"
echo "  Port: $db_port"
echo "  User: $db_user"
echo "  Password: [hidden]"
echo

echo "=== Examples Complete ==="
