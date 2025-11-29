# System Functions

The system functions provide utilities for gathering system information and performing system-level checks.

## Table of Contents
- [get_current_user](#get_current_user)
- [get_distribution](#get_distribution)
- [check_distribution](#check_distribution)
- [generate_ssh_key](#generate_ssh_key)
- [add_to_path](#add_to_path)
- [create_path_link](#create_path_link)

## Function Documentation

### get_current_user

Gets the current non-root user, even when running with sudo.

**Usage:**
```bash
current_user=$(get_current_user)
echo "Current user: $current_user"
```

**Description:**
This function attempts to determine the original non-root user when the script is run with sudo. It tries multiple methods:
1. First tries `logname`
2. Falls back to `whoami`
3. Checks `SUDO_USER` environment variable
4. Checks the parent process user

If it cannot determine a non-root user, it calls `error_exit` to terminate the script.

**Returns:**
The username of the non-root user.

---

### get_distribution

Gets the current Linux distribution information.

**Usage:**
```bash
distribution=$(get_distribution)
echo "Distribution: $distribution"
```

**Description:**
This function identifies the Linux distribution by:
1. Using `lsb_release` command if available
2. Falling back to reading `/etc/os-release` file
3. Returns "unknown" if neither method works

The distribution ID is converted to lowercase for consistency.

**Returns:**
The distribution ID in lowercase (e.g., "ubuntu", "debian", "centos")

---

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
This function compares the current distribution (from `get_distribution()`) against a space-separated list of supported distributions. If the current distribution is found in the list, it returns 0 (success). If not found, it calls `error_exit` to terminate the script with an error message.

**Parameters:**
- `$1`: Space-separated list of supported distribution names

**Returns:**
- 0 if distribution is supported
- Calls `error_exit` if distribution is not supported

**Note:** When using in conditionals, run in a subshell to prevent the entire script from exiting on unsupported distributions.

---

### generate_ssh_key

Generates SSH key pairs with specified parameters.

**Usage:**
```bash
generate_ssh_key "/path/to/key" "email@example.com" "rsa" 4096
```

**Description:**
This function generates SSH key pairs using the ssh-keygen command. It allows customization of key type, size, and comment. The function will create the necessary directory structure if it doesn't exist.

**Parameters:**
- `$1`: Path where the private key will be stored (public key will be at the same path with .pub extension)
- `$2`: Comment for the key (typically email)
- `$3`: Key type (rsa, ed25519, etc.)
- `$4`: Key size in bits

**Returns:**
- 0 on success
- Calls `error_exit` on failure

