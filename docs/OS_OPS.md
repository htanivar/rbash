# Utility Functions

The project provides utility capabilities through `functions/os_ops.sh`:

## Table of Contents

- [create_directory](#create_directory)
- [backup_file](#backup_file)

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

