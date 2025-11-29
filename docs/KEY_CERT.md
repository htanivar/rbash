# Key & Cert Functions

The key & cert functions provide utilities for gathering system information and performing system-level checks.

## Table of Contents

- [generate_ssh_key](#generate_ssh_key)

### generate_ssh_key

Generates SSH key pairs with specified parameters.

**Usage:**

```bash
generate_ssh_key "/path/to/key" "email@example.com" "rsa" 4096
```

**Description:**
This function generates SSH key pairs using the ssh-keygen command. It allows customization of key type, size, and
comment. The function will create the necessary directory structure if it doesn't exist.

**Parameters:**

- `$1`: Path where the private key will be stored (public key will be at the same path with .pub extension)
- `$2`: Comment for the key (typically email)
- `$3`: Key type (rsa, ed25519, etc.)
- `$4`: Key size in bits

**Returns:**

- 0 on success
- Calls `error_exit` on failure