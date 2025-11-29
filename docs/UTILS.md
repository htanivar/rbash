# Utility Functions

The project provides utility capabilities through `functions/utils.sh`:

## Table of Contents

- [generate_random_string](#generate_random_string)


### generate_random_string

Generates random string

**Usage:**

```bash
generate_random_string [length] [charset]
```

**Parameters:**

- `length`: Length of the random string (default: 16)
- `charset`: Character set to use (default: A-Za-z0-9)

**Returns:**
Random string

**Example:**

```bash
# Generate 16-character alphanumeric string
generate_random_string 16

# Generate 8-digit numeric string
generate_random_string 8 '0-9'

# Generate 20-character string with letters only
generate_random_string 20 'A-Za-z'
```
