# System Management Functions

This document describes the system management functions available in `functions/root/system.sh`.

## Table of Contents

- [set_hostname](#set_hostname)
- [set_fqdn](#set_fqdn)
- [add_swap_memory](#add_swap_memory)
- [remove_swap_memory](#remove_swap_memory)
- [update_system](#update_system)
- [clean_system](#clean_system)
- [detect_package_manager](#detect_package_manager)

## Function Documentation

### set_hostname

Sets the system hostname and updates /etc/hosts.

**Usage:**
```bash
set_hostname "new_hostname" ["fqdn"]
```

**Parameters:**
- `new_hostname`: The new hostname to set
- `fqdn` (optional): The fully qualified domain name (defaults to new_hostname)

**Examples:**
```bash
# Set hostname only
set_hostname "myserver"

# Set hostname with FQDN
set_hostname "myserver" "myserver.example.com"
```

**Notes:**
- Requires root privileges
- Updates both hostname and /etc/hosts file
- Creates a backup of /etc/hosts before modification

### set_fqdn

Sets the system FQDN and hostname.

**Usage:**
```bash
set_fqdn "fqdn" ["hostname"]
```

**Parameters:**
- `fqdn`: The fully qualified domain name
- `hostname` (optional): The hostname portion (defaults to first part of FQDN)

**Examples:**
```bash
# Set FQDN with automatic hostname extraction
set_fqdn "server.example.com"

# Set FQDN with custom hostname
set_fqdn "server.example.com" "custom-host"
```

**Notes:**
- Requires root privileges
- Internally calls set_hostname function

### add_swap_memory

Adds swap memory with specified size.

**Usage:**
```bash
add_swap_memory ["size"] ["swap_file"]
```

**Parameters:**
- `size` (optional): Swap size (default: "2G")
- `swap_file` (optional): Swap file path (default: "/swapfile")

**Examples:**
```bash
# Add default 2GB swap
add_swap_memory

# Add 4GB swap
add_swap_memory "4G"

# Add swap to custom location
add_swap_memory "1G" "/custom/swapfile"
```

**Notes:**
- Requires root privileges
- Creates persistent swap that survives reboots
- Verifies swap was added successfully
- Will warn if swap file already exists

### remove_swap_memory

Removes swap memory and cleans up.

**Usage:**
```bash
remove_swap_memory ["swap_file"]
```

**Parameters:**
- `swap_file` (optional): Swap file path to remove (default: "/swapfile")

**Examples:**
```bash
# Remove default swap file
remove_swap_memory

# Remove custom swap file
remove_swap_memory "/custom/swapfile"
```

**Notes:**
- Requires root privileges
- Disables swap, removes from fstab, and deletes the file
- Will warn if swap cannot be disabled

### update_system

Updates system packages using the detected package manager.

**Usage:**
```bash
update_system ["upgrade"]
```

**Parameters:**
- `upgrade` (optional): Whether to upgrade packages (default: "true")

**Examples:**
```bash
# Update package lists and upgrade packages
update_system

# Only update package lists without upgrading
update_system "false"
```

**Notes:**
- Requires root privileges
- Supports apt, yum, dnf, pacman, and zypper package managers
- Will error on unsupported package managers

### clean_system

Cleans system packages and cache.

**Usage:**
```bash
clean_system
```

**Examples:**
```bash
# Clean system packages
clean_system
```

**Notes:**
- Requires root privileges
- Removes unnecessary packages and cleans cache
- Supports apt, yum, dnf, pacman, and zypper package managers
- Will warn on unsupported package managers

### detect_package_manager

Detects the system's package manager.

**Usage:**
```bash
detect_package_manager
```

**Examples:**
```bash
# Detect package manager
package_manager=$(detect_package_manager)
echo "Package manager: $package_manager"
```

**Return Value:**
- Returns the name of the package manager (apt, dnf, yum, pacman, zypper)
- Returns "unknown" if no supported package manager is found

**Notes:**
- This is a helper function used internally by other system functions
- Can be used in scripts to conditionally execute package manager-specific commands
