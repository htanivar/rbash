#!/bin/bash
# --- Infra ---
alias taga-info='cat secret | grep taga'
alias taga-mail='/apps/firefox/firefox -P taga -no-remote https://www.gmail.com &'
alias taga-domain='/apps/firefox/firefox -P taga -no-remote https://www.godaddy.com &'
alias taga-host='/apps/firefox/firefox -P taga -no-remote https://hpanel.hostinger.com/vps/992688/overview &'
alias taga-github='/apps/firefox/firefox -P taga -no-remote https://www.github.com/nammataga &'
alias taga-cloudflare='/apps/firefox/firefox -P taga -no-remote https://dash.cloudflare.com &'

# --- Local Navigation ---
alias tagaWeb='cd ~/code/github/nammataga/taga-web'
alias tagaApi='cd ~/code/github/nammataga/taga-api'


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



alias LocalTaga='/apps/firefox/firefox -P taga -no-remote http://localhost:1701/ &'
alias swaggerLocalTaga='/apps/firefox/firefox -P taga -no-remote  http://localhost:1801/swagger/index.html &'

alias devTaga='/apps/firefox/firefox -P taga -no-remote  https://dev.nammataga.com/ &'
alias swaggerDevTaga='/apps/firefox/firefox -P taga -no-remote  https://devapi.nammataga.com/swagger/index.html &'

alias tstTaga='/apps/firefox/firefox -P taga -no-remote  https://tst.nammataga.com/ &'
alias swaggerTstTaga='/apps/firefox/firefox -P taga -no-remote  https://tstapi.nammataga.com/swagger/index.html &'

alias nammataga='/apps/firefox/firefox -P taga -no-remote  https://nammataga.com/ &'
alias swaggerNammataga='/apps/firefox/firefox -P taga -no-remote  https://nammataga.com/swagger/index.html &'


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
            ls
            chmod +x ./dev-ops.sh
            ./dev-ops.sh kill
        else
            echo "Error: 'dev-ops.sh' not found in $(pwd)"
        fi
    else
        echo "Error: Failed to change directory."
    fi
}

startLocalTagaWeb() {
    # Move to folder
    tagaWeb

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