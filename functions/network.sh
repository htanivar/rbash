#!/bin/bash

# Check if port is available
check_port() {
    local port="$1"
    local host="${2:-127.0.0.1}"

    if command -v nc &> /dev/null; then
        nc -z "$host" "$port" 2>/dev/null && return 1 || return 0
    elif command -v ss &> /dev/null; then
        ss -tuln | grep -q ":$port " && return 1 || return 0
    else
        warn "Cannot check port availability - neither nc nor ss available"
        return 0
    fi
}
