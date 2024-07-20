prependpath() {
    local p=${1:a}
    (( ! $path[(I)$p] )) && [[ -d $p ]] && path=($p $path)
}

appendpath() {
    local p=${1:a}
    (( ! $path[(I)$p] )) && [[ -d $p ]] && path=($path $p)
}

mcd() {
    [[ -n "$1" ]] && mkdir -p "$1" && cd "$1" || true
}
compdef _mkdir mcd  # https://github.com/robbyrussell/oh-my-zsh/issues/1895

refresh-env() {
    [[ -n $TMUX ]] || return
    local v env
    for v in $@; do
        env=$(tmux show-environment | grep "^$v=")
        [[ -z $env ]] || export $env
    done
}

_refresh-env() {
    compadd $(tmux show-environment | awk -F= '$0 !~ /^-/ { print $1 }')
}
compdef _refresh-env refresh-env

color_codes() {
    local fgc bgc vals seq0

    printf "Color escapes are %s\n" '\e[${value};...;${value}m'
    printf "Values 30..37 are \e[33mforeground colors\e[m\n"
    printf "Values 40..47 are \e[43mbackground colors\e[m\n"
    printf "Value  1 gives a  \e[1mbold-faced look\e[m\n"
    printf "Value  2 gives a  \e[2mfaint look\e[m\n"
    printf "Value  3 gives a  \e[3mitalic look\e[m\n"
    printf "Value  4 gives a  \e[4munderlined look\e[m\n"
    printf "Value  5 gives a  \e[5mblinking look\e[m\n"
    printf "Value  7 gives a  \e[7mreversed look\e[m\n"
    printf "Value  9 gives a  \e[9mcrossed-out look\e[m\n"
    echo

    # foreground colors
    for fgc in {30..37}; do
        # background colors
        for bgc in {40..47}; do
            fgc=${fgc#37} # white
            bgc=${bgc#40} # black

            vals="${fgc:+$fgc;}${bgc}"
            vals=${vals%%;}

            seq0="${vals:+\e[${vals}m}"
            printf "  %-9s" "${seq0:-\e[37m}"
            printf " ${seq0}TEXT\e[m"
            printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
        done
        echo; echo
    done
}

# from ohmyzsh
zsh_stats() {
    fc -l 1 |
        awk '$2 !~ /\// { CMD[$2]++; count++; } END { for (a in CMD) printf "%s %f%% %s\n",CMD[a],CMD[a]*100/count,a }' |
        sort -nr | head -20 | column -c3 -ts' ' | nl
}

d() {
    if [[ -n $1 ]]; then
        dirs "$@"
    else
        dirs -v | head -10
    fi
}
compdef _dirs d
