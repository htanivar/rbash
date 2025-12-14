#!/bin/bash
# --- Application & Software Launches ---
alias start-warp='warp'
alias keepass='keepassxc &'

alias gimp='/apps/gimp/GIMP-3.0.0-RC3-x86_64.AppImage  >> /dev/null 2>&1&'
alias xgimp='pkill -f /apps/gimp/GIMP-3.0.0-RC3-x86_64.AppImage'

alias code='/apps/code/bin/code >> /dev/null 2>&1&'
alias xcode='pkill -f /apps/code/bin/code'

alias idea='/apps/intellij/bin/idea >> /dev/null 2>&1&'
alias xidea='pkill -f /apps/intellij/bin/idea'

alias pycharm='/apps/pycharm/bin/pycharm  >> /dev/null 2>&1&'
alias xpycharm='pkill -f /apps/pycharm/bin/pycharm'

alias webstorm='/apps/webstorm/bin/webstorm  >> /dev/null 2>&1&'
alias xwebstorm='pkill -f /apps/webstorm/bin/webstorm'

alias goland='/apps/goland/bin/goland  >> /dev/null 2>&1&'
alias xgoland='pkill -f /apps/goland/bin/goland'

alias astudio='/apps/android-studio/bin/studio  >> /dev/null 2>&1&'
alias xastudio='pkill -f /apps/android-studio/bin/studio'

alias xpad='rm -rf ~/.config/xpad && xpad & disown'


alias ravi-fox='firefox -P ravi &'
alias xravi-fox='pkill -f "firefox -P ravi"'

alias editrc='gedit ~/.commonrc & disown'
alias rnotes='gedit ~/ravi-notes.txt & disown'
alias askgpt='gedit ~/gpt-notes.txt & disown'
alias gptnotes='gedit ~/gpt-notes.txt'
