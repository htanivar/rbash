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



# --- Find Prefix ---
alias shoppingSites="compgen -a | grep '^sh-'"
alias dealSites="compgen -a | grep '^dl-'"
alias travelSites="compgen -a | grep '^tr-'"
alias accomodationSites="compgen -a | grep '^ac-'"
alias IndianGovSites="compgen -a | grep '^in-'"
alias TNGovSites="compgen -a | grep '^tn-'"
alias courtSites="compgen -a | grep -E '^(sc|hc|tn|law)-' | sort"


alias sites="compgen -a | grep 'Sites$'"
