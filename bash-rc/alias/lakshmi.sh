#!/bin/bash
# --- Infra ---
#alias lakshmi-info='cat secret | grep lakshmi'
alias lakshmi-mail='firefox -P "lakshmi" https://www.gmail.com &'
alias lakshmi-domain='firefox -P "lakshmi" https://www.godaddy.com &'
alias lakshmi-host='firefox -P "lakshmi" https://hpanel.hostinger.com/vps/1468325/overview &'
alias lakshmi-github='firefox -P "lakshmi" https://www.github.com/ &'
alias lakshmi-cloudflare='firefox -P "lakshmi" https://dash.cloudflare.com &'

# --- Local Navigation ---


alias lakshmiBackoffice='cd ~/code/github/lakshmi-traders/backoffice'
alias lakshmiMobile='cd ~/code/github/lakshmi-traders/mobile-app'


# --- Remote Navigation ---
alias lakshmi-root='ssh root@lakshmi-prod'
alias lakshmi-admin='ssh ravi-adm@lakshmi-prod'
alias lakshmi-sys='ssh sys-lakshmi@lakshmi-prod'
alias lsshdev='ssh dev@lakshmi-prod'
alias lakshmi-ravi='ssh ravi@lakshmi-prod'

# For Production
#export PUBLISH_PROD_USER="ravi_adm"
#export PUBLISH_PROD_HOST="ravinath-prod"
#export PUBLISH_PROD_PATH="/apps/nammalakshmi"
#
alias web-dev-lakshmi='firefox -P lakshmi http://lakshmi-prod:3000/ &'
#alias swaggerLocallakshmi='firefox -P lakshmi http://localhost:2801/swagger/index.html &'
#alias swaggerDevlakshmi='firefox -P lakshmi https://devapi.nammalakshmi.com/swagger/index.html &'
#alias swaggerTstlakshmi='firefox -P lakshmi https://tstapi.nammalakshmi.com/swagger/index.html &'
#
#startLocallakshmiApi() {
#    # Move to folder
#    lakshmiApi
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
#killLocallakshmi() {
#    # Move to folder
#    lakshmiApi
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
#startLocallakshmiUi() {
#    # Move to folder
#    lakshmiUi
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

alias l-abacus='firefox -P "lakshmi" https://apps.abacus.ai &'
alias l-deepseek='firefox -P "lakshmi" https://chat.deepseek.com &'
alias l-perp='firefox -P "lakshmi" https://perplexity.ai &'
alias l-gemini='firefox -P "lakshmi" https://gemini.google.com &'
alias l-aistudio='firefox -P "lakshmi" https://aistudio.google.com &'
alias l-chatgpt='firefox -P "lakshmi" https://chat.openai.com &'
alias l-claude='firefox -P "lakshmi" https://claude.ai &'
alias l-gemini='firefox -P "lakshmi" https://gemini.google.com &'
alias l-copilot='firefox -P "lakshmi" https://copilot.microsoft.com &'
alias l-pi='firefox -P "lakshmi" https://pi.ai &'
alias l-you='firefox -P "lakshmi" https://you.com &'
alias l-poe='firefox -P "lakshmi" https://poe.com &'