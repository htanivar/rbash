#!/bin/bash

# --- DB ---
export DB_HOST="ai-dev"
export DB_PORT="5432"
export DB_USER="dbadmin"
export DB_PASSWORD="dev123!@#"
export DB_NAME="dev_db"
export DB_SSLMODE="disable"

# --- Infra ---
#alias laxmi-info='cat secret | grep laxmi'
alias laxmi-mail='firefox -P "laxmi" https://www.gmail.com &'
alias laxmi-domain='firefox -P "laxmi" https://www.godaddy.com &'
alias laxmi-host='firefox -P "laxmi" https://hpanel.hostinger.com/vps/1468325/overview &'
alias laxmi-github='firefox -P "laxmi" https://www.github.com/ &'
alias laxmi-cloudflare='firefox -P "laxmi" https://dash.cloudflare.com &'
alias laxmi-figma='firefox -P "laxmi" https://figma.com &'
alias dev-laxmi='firefox -P "laxmi" https://dev.laxmi.srilakshmiretail.in &'
alias dev-varam='firefox -P "laxmi" https://dev.varam.srilakshmiretail.in/swagger/index.html &'


# --- Local Navigation ---


alias laxmiBackoffice='cd ~/code/github/laxmi-traders/backoffice'
alias laxmiMobile='cd ~/code/github/laxmi-traders/mobile-app'


# --- Remote Navigation ---
alias laxmi-root='ssh root@laxmi-prod'
alias lsshadmin='ssh ravi-adm@laxmi-prod'
alias laxmi-sys='ssh sys-laxmi@laxmi-prod'
alias lsshdev='ssh dev@laxmi-prod'
alias laxmi-ravi='ssh ravi@laxmi-prod'

# For Production
#export PUBLISH_PROD_USER="ravi_adm"
#export PUBLISH_PROD_HOST="ravinath-prod"
#export PUBLISH_PROD_PATH="/apps/nammalaxmi"
#
alias web-dev-laxmi='firefox -P laxmi http://laxmi-prod:3000/ &'
#alias swaggerLocallaxmi='firefox -P laxmi http://localhost:2801/swagger/index.html &'
#alias swaggerDevlaxmi='firefox -P laxmi https://devapi.nammalaxmi.com/swagger/index.html &'
#alias swaggerTstlaxmi='firefox -P laxmi https://tstapi.nammalaxmi.com/swagger/index.html &'
#
#startLocallaxmiApi() {
#    # Move to folder
#    laxmiApi
#
#    if [ $? -eq 0 ]; then
#        echo "Successfully moved to: $(pwd)"
#
#        # Check for the correct filename: dev-ops.sh
#        if [ -f "./dev-ops.sh" ]; then
#            chmod +x ./dev-ops.sh
#            ./dev-ops.sh start
#        else
#            echo "Error: 'dev-ops.sh' not found in $(pwd)"
#        fi
#    else
#        echo "Error: Failed to change directory."
#    fi
#}
#
#killLocallaxmi() {
#    # Move to folder
#    laxmiApi
#
#    if [ $? -eq 0 ]; then
#        echo "Successfully moved to: $(pwd)"
#
#        # Check for the correct filename: dev-ops.sh
#        if [ -f "./dev-ops.sh" ]; then
#            chmod +x ./dev-ops.sh
#            ./dev-ops.sh kill
#        else
#            echo "Error: 'dev-ops.sh' not found in $(pwd)"
#        fi
#    else
#        echo "Error: Failed to change directory."
#    fi
#}
#
#startLocallaxmiUi() {
#    # Move to folder
#    laxmiUi
#
#    if [ $? -eq 0 ]; then
#        echo "Successfully moved to: $(pwd)"
#
#        # Check for the correct filename: dev-ops.sh
#        if [ -f "./run.sh" ]; then
#            chmod +x ./run.sh
#            ./run.sh local
#        else
#            echo "Error: 'run.sh' not found in $(pwd)"
#        fi
#    else
#        echo "Error: Failed to change directory."
#    fi
#}

alias l-abacus='firefox -P "laxmi" https://apps.abacus.ai &'
alias l-deepseek='firefox -P "laxmi" https://chat.deepseek.com &'
alias l-perp='firefox -P "laxmi" https://perplexity.ai &'
alias l-gemini='firefox -P "laxmi" https://gemini.google.com &'
alias l-aistudio='firefox -P "laxmi" https://aistudio.google.com &'
alias l-chatgpt='firefox -P "laxmi" https://chat.openai.com &'
alias l-claude='firefox -P "laxmi" https://claude.ai &'
alias l-gemini='firefox -P "laxmi" https://gemini.google.com &'
alias l-copilot='firefox -P "laxmi" https://copilot.microsoft.com &'
alias l-pi='firefox -P "laxmi" https://pi.ai &'
alias l-you='firefox -P "laxmi" https://you.com &'
alias l-poe='firefox -P "laxmi" https://poe.com &'