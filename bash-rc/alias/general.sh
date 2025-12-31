#!/bin/bash
# --- Shell Reload ---
# Reload the shell configuration
if [ -n "$BASH_VERSION" ]; then
    alias reload='source ~/.bashrc'
elif [ -n "$ZSH_VERSION" ]; then
    alias reload='source ~/.zshrc'
fi

# --- General & System ---
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias v='vim'
alias cp='cp -i'    # confirm before overwrite
alias mv='mv -i'
alias rm='rm -i'



