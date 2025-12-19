#!/bin/bash
# --- Infra ---
alias taga-info='cat secret | grep taga'
alias taga-domain='xdg-open https://www.godaddy.com &'
alias taga-host='xdg-open https://hpanel.hostinger.com/vps/992688/overview &'
alias taga-github='xdg-open https://www.github.com/nammataga &'
alias taga-cloudflare='xdg-open https://dash.cloudflare.com &'

# --- Local Navigation ---
alias tagaUi='cd ~/code/github/nammataga/prod/taga-ui'
alias tagaApi='cd ~/code/github/nammataga/prod/taga-api'


# --- Remote Navigation ---
alias taga-root='ssh root@taga-prod'
alias taga-admin='ssh admin-taga@taga-prod'
alias taga-sys='ssh sys-taga@taga-prod'
alias taga-dev='ssh dev@taga-prod'
alias taga-vm='ssh ravi@vm-taga'

# For Production
export PUBLISH_PROD_USER="ravi_adm"
export PUBLISH_PROD_HOST="ravinath-prod"
export PUBLISH_PROD_PATH="/apps/nammataga"