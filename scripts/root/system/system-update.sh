#!/bin/bash

# Source the main loader instead of individual files
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)/core-loader.sh"

prompt_input "Enter Remote username: " "REMOTE_USER" "ravi"
require_var "REMOTE_USER"
prompt_input "Enter Remote Host: " "REMOTE_HOST" "192.168.1.79"
require_var "REMOTE_HOST"

must_be_root
update_system
copy_remote_file $REMOTE_USER $REMOTE_HOST "/etc/hosts" "/etc/hosts"
