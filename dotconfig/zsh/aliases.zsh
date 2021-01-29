alias rm="rm -I"
alias cp="cp -i"
alias mv="mv -i"
alias ls="ls --color=auto"
alias free="free -h"
alias grep="grep --color=auto"
alias ip="env COLORFGBG=';0' ip -c=auto"
alias sudo="sudo "
alias swl="swl "
alias alwaysatty="alwaysatty "
alias proxied="proxied "

alias tatt="tmux attach -t"
alias tnew="tmux new -s"

alias gdb="gdb -q"
alias bc="bc -lq"

alias rsbk="env RUST_BACKTRACE=1 "
alias langzh="env -u LC_TIME LANG=zh_CN.UTF-8 "

alias pys="python3 -m http.server"

alias :q="exit"
alias :e="${EDITOR:-vim}"

alias -s {pdf,png,jpg,jpeg,gif,svg,html}="open"
alias -s {mov,mkv,flv,mp4,rmvb}="open"
alias -s {m4a,ogg,mp3,aac,wav}="open"
alias -s zip="open"
alias -s csv="csview"
