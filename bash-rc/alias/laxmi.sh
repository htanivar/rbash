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
alias laxmi-mail='/apps/firefox/firefox -P laxmi -no-remote  https://www.gmail.com &'
alias laxmi-domain='/apps/firefox/firefox -P laxmi -no-remote  https://www.godaddy.com &'
alias laxmi-host='/apps/firefox/firefox -P laxmi -no-remote  https://hpanel.hostinger.com/vps/1468325/overview &'
alias laxmi-github='/apps/firefox/firefox -P laxmi -no-remote  https://www.github.com/ &'
alias laxmi-cloudflare='/apps/firefox/firefox -P laxmi -no-remote  https://dash.cloudflare.com &'
alias laxmi-figma='/apps/firefox/firefox -P laxmi -no-remote  https://figma.com &'
alias dev-laxmi='/apps/firefox/firefox -P laxmi -no-remote  https://dev.laxmi.srilakshmiretail.in &'
alias dev-varam='/apps/firefox/firefox -P laxmi -no-remote  https://dev.varam.srilakshmiretail.in/swagger/index.html &'


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
alias localLaxmi='/apps/firefox/firefox -P laxmi -no-remote http://localhost:2801/swagger/index.html &'
alias swaggerLocalVaram='/apps/firefox/firefox -P laxmi -no-remote http://localhost:2801/swagger/index.html &'
alias swaggerDevVaram='/apps/firefox/firefox -P laxmi -no-remote https://dev.varam.srilakshmiretail.in/swagger/index.html &'
#alias swaggerTstlaxmi='/apps/firefox/firefox -P laxmi -no-remote https://tstapi.nammalaxmi.com/swagger/index.html &'
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

alias l-abacus='/apps/firefox/firefox -P laxmi -no-remote  https://apps.abacus.ai &'
alias l-deepseek='/apps/firefox/firefox -P laxmi -no-remote  https://chat.deepseek.com &'
alias l-perp='/apps/firefox/firefox -P laxmi -no-remote  https://perplexity.ai &'
alias l-gemini='/apps/firefox/firefox -P laxmi -no-remote  https://gemini.google.com &'
alias l-aistudio='/apps/firefox/firefox -P laxmi -no-remote  https://aistudio.google.com &'
alias l-chatgpt='/apps/firefox/firefox -P laxmi -no-remote  https://chat.openai.com &'
alias l-claude='/apps/firefox/firefox -P laxmi -no-remote  https://claude.ai &'
alias l-gemini='/apps/firefox/firefox -P laxmi -no-remote  https://gemini.google.com &'
alias l-copilot='/apps/firefox/firefox -P laxmi -no-remote  https://copilot.microsoft.com &'
alias l-pi='/apps/firefox/firefox -P laxmi -no-remote  https://pi.ai &'
alias l-you='/apps/firefox/firefox -P laxmi -no-remote  https://you.com &'
alias l-poe='/apps/firefox/firefox -P laxmi -no-remote  https://poe.com &'