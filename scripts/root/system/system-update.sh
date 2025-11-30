#!/bin/bash

# Source the main loader instead of individual files
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)/core-loader.sh"

must_be_root
update_system