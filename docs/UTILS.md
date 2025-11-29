# Utility Functions

The project provides utility capabilities through `functions/utils.sh`:

## Core Functions

### create_directory

Creates directory with proper ownership and permissions

**Usage:**
```bash
create_directory "/path/to/directory" [owner] [group] [permissions]
```

**Parameters:**
- `dir_path`: Path to the directory to create
- `owner`: Owner of the directory (default: current user)
- `group`: Group of the directory (default: owner)
- `permissions`: Directory permissions (default: 755)

**Example:**
```bash
create_directory "/var/log/myapp" "www-data" "www-data" "750"
```

### backup_file

Backs up file with timestamp

**Usage:**
```bash
backup_file "/path/to/file" [backup_directory]
```

**Parameters:**
- `file_path`: Path to the file to backup
- `backup_dir`: Directory where backup will be stored (default: same directory as original file)

**Returns:**
Path to the backup file

**Example:**
```bash
backup_file "/etc/nginx/nginx.conf" "/opt/backups"
```

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
