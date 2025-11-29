# Utility Functions

The project provides utility capabilities through `functions/network.sh`:

## Table of Contents

- [check_port](#check_port)

### check_port

Checks if port is available

**Usage:**

```bash
check_port port [host]
```

**Parameters:**

- `port`: Port number to check
- `host`: Host to check (default: 127.0.0.1)

**Returns:**

- 0 (success) if port is available
- 1 (failure) if port is in use

**Example:**

```bash
if check_port 8080; then
    echo "Port 8080 is available"
else
    echo "Port 8080 is in use"
fi
```
