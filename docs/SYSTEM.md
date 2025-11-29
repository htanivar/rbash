# System Functions

The system functions provide utilities for gathering system information and performing system-level checks.

## Table of Contents
- [get_current_user](#get_current_user)
- [get_distribution](#get_distribution)
- [check_distribution](#check_distribution)

## Function Documentation

### get_current_user

Gets the current non-root user, even when running with sudo.

**Usage:**

```bash
current_user=$(get_current_user)
echo "Current user: $current_user"
```

**Description:**
This function attempts to determine the original non-root user when the script is run with sudo. It tries multiple
methods:

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

