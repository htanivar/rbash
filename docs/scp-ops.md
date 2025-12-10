# SCP Operations Functions

The project provides SCP (Secure Copy Protocol) operations capabilities through `functions/scp_ops.sh`. These functions enable secure file transfers between local and remote systems using SSH.

## Table of Contents

- [copy_remote_file()](#copy_remote_file)
- [copy_to_remote()](#copy_to_remote)
- [copy_remote_directory()](#copy_remote_directory)
- [copy_directory_to_remote()](#copy_directory_to_remote)
- [test_ssh_connection()](#test_ssh_connection)
- [create_remote_directory()](#create_remote_directory)
- [create_remote_directories()](#create_remote_directories)
- [Usage Examples](#usage-examples)
- [Best Practices](#best-practices)

## Function Reference

### copy_remote_file()

Copy a file from a remote host to the local system using SCP.

**Syntax:**
```bash
copy_remote_file remote_user remote_host remote_path local_path [scp_options]
```

**Parameters:**
- `remote_user`: Username on the remote host
- `remote_host`: Hostname or IP address of the remote host
- `remote_path`: Path to the file on the remote host
- `local_path`: Local destination path
- `scp_options` (optional): Additional SCP options (e.g., "-P 2222 -i ~/.ssh/id_rsa")

**Returns:**
- `0` on success
- `1` on failure

**Example:**
```bash
copy_remote_file "user" "example.com" "/home/user/file.txt" "/tmp/local_file.txt"
```

### copy_to_remote()

Copy a file from the local system to a remote host using SCP.

**Syntax:**
```bash
copy_to_remote local_path remote_user remote_host remote_path [scp_options]
```

**Parameters:**
- `local_path`: Path to the local file
- `remote_user`: Username on the remote host
- `remote_host`: Hostname or IP address of the remote host
- `remote_path`: Destination path on the remote host
- `scp_options` (optional): Additional SCP options

**Returns:**
- `0` on success
- `1` on failure

**Example:**
```bash
copy_to_remote "/tmp/local_file.txt" "user" "example.com" "/home/user/uploaded_file.txt"
```

### copy_remote_directory()

Copy a directory recursively from a remote host to the local system using SCP.

**Syntax:**
```bash
copy_remote_directory remote_user remote_host remote_path local_path [scp_options]
```

**Parameters:**
- `remote_user`: Username on the remote host
- `remote_host`: Hostname or IP address of the remote host
- `remote_path`: Path to the directory on the remote host
- `local_path`: Local destination path
- `scp_options` (optional): Additional SCP options

**Returns:**
- `0` on success
- `1` on failure

**Example:**
```bash
copy_remote_directory "user" "example.com" "/home/user/data" "/tmp/backup"
```

### copy_directory_to_remote()

Copy a directory recursively from the local system to a remote host using SCP.

**Syntax:**
```bash
copy_directory_to_remote local_path remote_user remote_host remote_path [scp_options]
```

**Parameters:**
- `local_path`: Path to the local directory
- `remote_user`: Username on the remote host
- `remote_host`: Hostname or IP address of the remote host
- `remote_path`: Destination path on the remote host
- `scp_options` (optional): Additional SCP options

**Returns:**
- `0` on success
- `1` on failure

**Example:**
```bash
copy_directory_to_remote "/tmp/data" "user" "example.com" "/home/user/backup"
```

### test_ssh_connection()

Test SSH connection to a remote host before performing SCP operations.

**Syntax:**
```bash
test_ssh_connection remote_user remote_host [ssh_options]
```

**Parameters:**
- `remote_user`: Username on the remote host
- `remote_host`: Hostname or IP address of the remote host
- `ssh_options` (optional): Additional SSH options

**Returns:**
- `0` on success (connection established)
- `1` on failure (connection failed)

**Example:**
```bash
test_ssh_connection "user" "example.com"
```

### create_remote_directory()

Create a directory on a remote host using SSH.

**Syntax:**
```bash
create_remote_directory remote_user remote_host remote_path [ssh_options] [permissions] [owner] [group]
```

**Parameters:**
- `remote_user`: Username on the remote host
- `remote_host`: Hostname or IP address of the remote host
- `remote_path`: Path to create on the remote host
- `ssh_options` (optional): Additional SSH options
- `permissions` (optional): Directory permissions (e.g., 755, 700)
- `owner` (optional): Directory owner
- `group` (optional): Directory group

**Returns:**
- `0` on success
- `1` on failure

**Example:**
```bash
# Create directory with default settings
create_remote_directory "user" "example.com" "/home/user/data"

# Create directory with specific permissions
create_remote_directory "user" "example.com" "/home/user/data" "" "755"

# Create directory with ownership and permissions
create_remote_directory "user" "example.com" "/home/user/data" "" "755" "user" "user"
```

### create_remote_directories()

Create multiple directories on a remote host using SSH.

**Syntax:**
```bash
create_remote_directories remote_user remote_host ssh_options directory1 directory2 ...
```

**Parameters:**
- `remote_user`: Username on the remote host
- `remote_host`: Hostname or IP address of the remote host
- `ssh_options` (optional): Additional SSH options
- `directory1`, `directory2`, ...: Directories to create

**Returns:**
- `0` on success
- `1` on failure

**Example:**
```bash
create_remote_directories "user" "example.com" "" "/home/user/data" "/home/user/logs" "/home/user/config"
```

## Usage Examples

For comprehensive examples with test scenarios, see [examples/scp_ops-functions.sh](../examples/scp_ops-functions.sh).

To run the examples:
```bash
# Basic demonstration (uses localhost)
bash examples/scp_ops-functions.sh

# Test with actual remote host
export TEST_USER="your_username"
export TEST_HOST="remote.example.com"
bash examples/scp_ops-functions.sh
```

## Best Practices

1. **SSH Key Authentication**: Set up SSH key-based authentication for password-less connections.
2. **Connection Testing**: Always test SSH connection with `test_ssh_connection()` before performing file transfers.
3. **Error Handling**: Check return codes and use proper error handling in your scripts.
4. **SCP Options**: Use appropriate SCP options for your environment:
   - `-P <port>`: Specify custom SSH port
   - `-i <identity_file>`: Use specific SSH identity file
   - `-C`: Enable compression for large files
   - `-q`: Quiet mode to suppress progress output
5. **Path Validation**: Ensure source files/directories exist before attempting transfers.
6. **Permissions**: Verify you have appropriate read/write permissions on both local and remote systems.

## Dependencies

These functions require:
- `scp` command (part of OpenSSH client)
- `ssh` command (for connection testing)
- Proper SSH configuration and access to remote hosts

## See Also

- [Network Functions](../docs/NETWORK.md) - For port checking and other network utilities
- [OS Operation Functions](../docs/OS_OPS.md) - For file and directory operations
- [Examples Directory](../examples/) - For more usage examples
