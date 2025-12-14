#!/bin/bash
# --- Docker Shortcuts ---
alias dil='dop image ls'
alias dcl='dop container list'
alias dcrm="dcl | awk 'NR > 2 {print \$NF}' | xargs -I {} dop container rm {}"

