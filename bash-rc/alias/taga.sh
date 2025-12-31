#!/bin/bash
# --- Infra ---
alias taga-info='cat secret | grep taga'
alias taga-domain='firefox -P "ravi" https://www.godaddy.com &'
alias taga-host='firefox -P "ravi" https://hpanel.hostinger.com/vps/992688/overview &'
alias taga-github='firefox -P "ravi" https://www.github.com/nammataga &'
alias taga-cloudflare='firefox -P "ravi" https://dash.cloudflare.com &'

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