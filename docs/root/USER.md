# User Management Functions

This document describes the user management functions available in `functions/root/user.sh`.

## Table of Contents

- [create_user()](#create_user)
- [create_admin_user()](#create_admin_user)
- [delete_user()](#delete_user)
- [add_user_to_group()](#add_user_to_group)
- [remove_user_from_group()](#remove_user_from_group)
- [setup_ssh_key()](#setup_ssh_key)
- [generate_ssh_key()](#generate_ssh_key)

## Function Documentation

### create_user()

Creates a new user with specified options.

**Usage:**
```bash
create_user "username" "password" ["home_dir"] ["shell"] ["groups"] ["create_home"]
```

**Parameters:**
- `username` (required): The username to create
- `password` (required): The user's password
- `home_dir` (optional): Home directory path (default: `/home/$username`)
- `shell` (optional): Login shell (default: `/bin/bash`)
- `groups` (optional): Supplementary groups (comma-separated)
- `create_home` (optional): Create home directory (default: `true`)

**Examples:**
```bash
# Basic user creation
create_user "john" "password123"

# User with custom home directory and shell
create_user "jane" "password456" "/opt/jane" "/bin/zsh"

# User with additional groups
create_user "bob" "password789" "/home/bob" "/bin/bash" "wheel,developers"

# User without home directory
create_user "service" "pass123" "/nonexistent" "/bin/false" "" "false"
```

### create_admin_user()

Creates a new admin user with sudo access.

**Usage:**
```bash
create_admin_user "username" "password" ["home_dir"] ["shell"]
```

**Parameters:**
- `username` (required): The username to create
- `password` (required): The user's password
- `home_dir` (optional): Home directory path (default: `/home/$username`)
- `shell` (optional): Login shell (default: `/bin/bash`)

**Examples:**
```bash
# Create admin user
create_admin_user "admin" "securepassword"

# Create admin user with custom settings
create_admin_user "superuser" "mypassword" "/home/super" "/bin/zsh"
```

### delete_user()

Deletes a user account.

**Usage:**
```bash
delete_user "username" ["remove_home"] ["remove_mail"]
```

**Parameters:**
- `username` (required): The username to delete
- `remove_home` (optional): Remove home directory and mail spool (default: `true`)
- `remove_mail` (optional): Force removal of mail spool (default: `true`)

**Examples:**
```bash
# Delete user and remove home directory
delete_user "john"

# Delete user but keep home directory
delete_user "jane" "false"

# Delete user, keep home, but remove mail
delete_user "bob" "false" "true"
```

### add_user_to_group()

Adds a user to a group.

**Usage:**
```bash
add_user_to_group "username" "group"
```

**Parameters:**
- `username` (required): The username
- `group` (required): The group name

**Examples:**
```bash
# Add user to sudo group
add_user_to_group "john" "sudo"

# Add user to multiple groups (call multiple times)
add_user_to_group "john" "docker"
add_user_to_group "john" "developers"
```

### remove_user_from_group()

Removes a user from a group.

**Usage:**
```bash
remove_user_from_group "username" "group"
```

**Parameters:**
- `username` (required): The username
- `group` (required): The group name

**Examples:**
```bash
# Remove user from group
remove_user_from_group "john" "sudo"
```

### setup_ssh_key()

Sets up an SSH key for a user.

**Usage:**
```bash
setup_ssh_key "username" "public_key_content" ["key_file"]
```

**Parameters:**
- `username` (required): The username
- `public_key_content` (required): The public key content
- `key_file` (optional): The authorized_keys filename (default: `authorized_keys`)

**Examples:**
```bash
# Setup SSH key
setup_ssh_key "john" "ssh-rsa AAAAB3NzaC1yc2E..."

# Setup SSH key with custom filename
setup_ssh_key "john" "ssh-rsa AAAAB3NzaC1yc2E..." "authorized_keys2"
```

### generate_ssh_key()

Generates an SSH key pair for a user.

**Usage:**
```bash
generate_ssh_key "username" ["key_type"] ["key_size"] ["comment"]
```

**Parameters:**
- `username` (required): The username
- `key_type` (optional): Key type (rsa, dsa, ecdsa, ed25519) (default: `rsa`)
- `key_size` (optional): Key size in bits (default: `4096`)
- `comment` (optional): Key comment (default: `$username@$(hostname)`)

**Examples:**
```bash
# Generate default RSA key
generate_ssh_key "john"

# Generate ED25519 key
generate_ssh_key "jane" "ed25519"

# Generate custom key
generate_ssh_key "bob" "rsa" "2048" "bob@company.com"
```

## Usage in Scripts

To use these functions in your scripts, first set `PROJECT_ROOT_DIR` and source the core loader:

```bash
#!/bin/bash

# Source the main loader
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/core-loader.sh"

# Now you can use the functions
create_user "testuser" "testpass"
```

**Note:** Most user management functions require root privileges and will call `must_be_root()` to enforce this.
