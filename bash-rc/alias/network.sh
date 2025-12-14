#!/bin/bash
# --- Network ---
alias localip="hostname -I | awk '{print $1}'"
alias myip="ip route get 1.1.1.1 | grep -oP 'src \K\S+'"
alias lanip="ip addr show | grep 'inet ' | grep -v '127.0.0.1' | head -1 | awk '{print $2}' | cut -d/ -f1"
alias publicip="curl -s4 ifconfig.me"
alias extip="curl -s4 ipecho.net/plain"
alias whatismyip="curl -s4 icanhazip.com"
alias ispip="echo 'Router WAN IP:' && curl -s4 http://192.168.1.1/status 2>/dev/null | grep -i 'wan\|internet' || echo 'Check router admin page manually' && echo 'Public IP:' && curl -s4 ifconfig.me && echo 'If different, your IP is shared by ISP'"
alias ips="echo 'Local IP:' && localip && echo 'Public IP:' && publicip"
alias checkInternet='ping -c 4 8.8.8.8'