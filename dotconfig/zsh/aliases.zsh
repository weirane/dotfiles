alias rm="rm -I"
alias cp="cp -i"
alias mv="mv -i"
alias ls="ls --color=auto"
alias free="free -h"
alias grep="grep --color=auto"
alias sudo="sudo "

alias tatt="tmux attach -t"
alias tnew="tmux new -s"

alias gdb="gdb -q"
alias bc="bc -lq"

alias rsbk="RUST_BACKTRACE=1"
alias langzh="LANG=zh_CN.UTF-8"

alias pys="python3 -m http.server"

alias :q="exit"

alias -s pdf="zathura --fork"
alias -s {svg,html,htm}="${BROWSER:-firefox}"
alias -s {png,jpg,jpeg}="setsid sxiv -N FloatExec"
alias -s gif="setsid mpv --loop=inf --player-operation-mode=pseudo-gui"
