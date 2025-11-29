# Input Functions

The project provides robust input handling capabilities through `functions/input.sh`:

## Core Functions

### prompt_input

Prompts for user input with validation, defaults, and secret input support.

**Usage:**
```bash
prompt_input "prompt_text" "var_name" ["default_value"] ["is_required"] ["is_secret"]
```

**Parameters:**
- `prompt_text`: The text to display to the user
- `var_name`: The name of the variable to store the input
- `default_value` (optional): Default value if user provides empty input
- `is_required` (optional): Whether input is required (default: true)
- `is_secret` (optional): Whether input should be hidden (for passwords) (default: false)

**Examples:**
```bash
# Basic required input
prompt_input "Enter your name" "user_name"

# Input with default value
prompt_input "Enter your favorite color" "favorite_color" "blue"

# Optional input
prompt_input "Enter your nickname (optional)" "nickname" "" "false"

# Secret input (password)
prompt_input "Enter your password" "password" "" "true" "true"
```

### confirm_action

Confirms actions with the user with customizable defaults.

**Usage:**
```bash
confirm_action "message" ["default"]
```

**Parameters:**
- `message`: The confirmation message to display
- `default` (optional): Default response ('y' for yes, 'n' for no) (default: 'n')

**Returns:**
- `0` (true) if user confirms
- `1` (false) if user declines

**Examples:**
```bash
# Default 'no'
if confirm_action "Do you want to proceed?"; then
    echo "User chose to proceed"
else
    echo "User chose to cancel"
fi

# Default 'yes'
if confirm_action "Do you want to continue?" "y"; then
    echo "Continuing..."
else
    echo "Stopping..."
fi
```

## Usage Examples

See [examples/input-functions.sh](../examples/input-functions.sh) for complete usage examples.
