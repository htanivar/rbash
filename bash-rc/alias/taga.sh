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

alias LocalTaga='firefox -P ravi http://localhost:1701/ &'
alias swaggerLocalTaga='firefox -P ravi http://localhost:1801/swagger/index.html &'
alias swaggerDevTaga='firefox -P ravi https://devapi.nammataga.com/swagger/index.html &'
alias swaggerTstTaga='firefox -P ravi https://tstapi.nammataga.com/swagger/index.html &'

startLocalTagaApi() {
    # Move to folder
    tagaApi

    if [ $? -eq 0 ]; then
        echo "Successfully moved to: $(pwd)"

        # Check for the correct filename: dev-ops.sh
        if [ -f "./dev-ops.sh" ]; then
            chmod +x ./dev-ops.sh
            ./dev-ops.sh start
        else
            echo "Error: 'dev-ops.sh' not found in $(pwd)"
        fi
    else
        echo "Error: Failed to change directory."
    fi
}

killLocalTaga() {
    # Move to folder
    tagaApi

    if [ $? -eq 0 ]; then
        echo "Successfully moved to: $(pwd)"

        # Check for the correct filename: dev-ops.sh
        if [ -f "./dev-ops.sh" ]; then
            chmod +x ./dev-ops.sh
            ./dev-ops.sh kill
        else
            echo "Error: 'dev-ops.sh' not found in $(pwd)"
        fi
    else
        echo "Error: Failed to change directory."
    fi
}

startLocalTagaUi() {
    # Move to folder
    tagaUi

    if [ $? -eq 0 ]; then
        echo "Successfully moved to: $(pwd)"

        # Check for the correct filename: dev-ops.sh
        if [ -f "./run.sh" ]; then
            chmod +x ./run.sh
            ./run.sh local
        else
            echo "Error: 'run.sh' not found in $(pwd)"
        fi
    else
        echo "Error: Failed to change directory."
    fi
}