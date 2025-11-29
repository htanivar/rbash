# Path Functions

The path functions provide utilities for gathering and manipulating path.

## Table of Contents
- [add_to_path](#add_to_path)
- [create_path_link](#create_path_link)

## Function Documentation

### add_to_path

Adds directories to the PATH environment variable.

**Usage:**
```bash
add_to_path "/usr/local/bin" "/opt/myapp/bin"
```

**Description:**
This function adds one or more directories to the PATH environment variable if they're not already present. It modifies the current shell's PATH.

**Parameters:**
- `$@`: One or more directory paths to add to PATH

**Returns:**
- 0 on success
- Calls `error_exit` if any directory doesn't exist


---

### create_path_link

Creates symbolic links in system paths.

**Usage:**
```bash
create_path_link "/path/to/source" "link_name"
```

**Description:**
This function creates symbolic links from source files/directories to a link name in the user's local bin directory (default: `$HOME/.local/bin`). It ensures the bin directory exists, handles backup of existing links, and adds the bin directory to PATH if not already present.

**Parameters:**
- `$1`: Source file/directory path
- `$2`: Link name (not full path, will be created in bin directory)
- `$3`: Optional custom bin directory (default: `$HOME/.local/bin`)

**Returns:**
- 0 on success
- Calls `error_exit` on failure
