#!/bin/bash
# --- Docker Shortcuts ---
alias dil='dop image ls'
alias dcl='dop container list'
alias dcrm="dcl | awk 'NR > 2 {print \$NF}' | xargs -I {} dop container rm {}"

# --- Minimal Linux Containers ---
# Build the image
alias dbuild='docker-compose build'

# Start all environments
alias dup='docker-compose up -d'

# Stop all environments
alias ddown='docker-compose down'

# Start specific environment
alias dup-dev='docker-compose up -d dev'
alias dup-tst='docker-compose up -d tst'
alias dup-stg='docker-compose up -d stg'
alias dup-prd='docker-compose up -d prd'

# Stop specific environment
alias dstop-dev='docker-compose stop dev'
alias dstop-tst='docker-compose stop tst'
alias dstop-stg='docker-compose stop stg'
alias dstop-prd='docker-compose stop prd'

# Logs for specific environment
alias dlogs-dev='docker-compose logs -f dev'
alias dlogs-tst='docker-compose logs -f tst'
alias dlogs-stg='docker-compose logs -f stg'
alias dlogs-prd='docker-compose logs -f prd'

# Shell access to containers
alias dsh-dev='docker exec -it minimal-linux-dev /bin/bash'
alias dsh-tst='docker exec -it minimal-linux-tst /bin/bash'
alias dsh-stg='docker exec -it minimal-linux-stg /bin/bash'
alias dsh-prd='docker exec -it minimal-linux-prd /bin/bash'

# View container status
alias dps='docker-compose ps'

# Rebuild and restart specific environment
alias dre-dev='docker-compose up -d --build dev'
alias dre-tst='docker-compose up -d --build tst'
alias dre-stg='docker-compose up -d --build stg'
alias dre-prd='docker-compose up -d --build prd'

