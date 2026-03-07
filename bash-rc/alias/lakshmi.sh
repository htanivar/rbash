#!/bin/bash
# --- Infra ---
#alias lakshmi-info='cat secret | grep lakshmi'
#alias lakshmi-domain='firefox -P "lakshmi" https://www.godaddy.com &'
#alias lakshmi-host='firefox -P "lakshmi" https://hpanel.hostinger.com/vps/992688/overview &'
#alias lakshmi-github='firefox -P "lakshmi" https://www.github.com/nammalakshmi &'
#alias lakshmi-cloudflare='firefox -P "lakshmi" https://dash.cloudflare.com &'

# --- Local Navigation ---
alias lakshmiBackoffice='cd ~/code/github/lakshmi-traders/backoffice'
alias lakshmiMobile='cd ~/code/github/lakshmi-traders/mobile-app'


# --- Remote Navigation ---
#alias lakshmi-root='ssh root@lakshmi-prod'
#alias lakshmi-admin='ssh admin-lakshmi@lakshmi-prod'
#alias lakshmi-sys='ssh sys-lakshmi@lakshmi-prod'
#alias lakshmi-dev='ssh dev@lakshmi-prod'
#alias lakshmi-vm='ssh ravi@vm-lakshmi'

# For Production
#export PUBLISH_PROD_USER="ravi_adm"
#export PUBLISH_PROD_HOST="ravinath-prod"
#export PUBLISH_PROD_PATH="/apps/nammalakshmi"
#
#alias Locallakshmi='firefox -P lakshmi http://localhost:2701/ &'
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