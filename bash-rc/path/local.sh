#!/bin/bash

# Ensure ~/bin exists
mkdir -p "$HOME/bin"

# Add local bin directories to the PATH
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Add ~/bin to PATH if not already present
if [[ ":$PATH:" != *":$HOME/bin:"* ]]; then
    export PATH="$HOME/bin:$PATH"
    echo "ℹ️  Added ~/bin to PATH for this session."
fi

