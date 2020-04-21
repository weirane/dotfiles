prependpath() {
    [ ! -d "$1" ] && return
    case ":$PATH:" in
        *:"$1":*) ;;
        *) export PATH="$1${PATH:+:$PATH}" ;;
    esac
}

appendpath() {
    [ ! -d "$1" ] && return
    case ":$PATH:" in
        *:"$1":*) ;;
        *) export PATH="${PATH:+$PATH:}$1" ;;
    esac
}

cmdof() {
    [ -z "$1" ] && return
    xargs -0 < "/proc/$1/cmdline"
}

envof() {
    [ -z "$1" ] && return
    tr '\0' '\n' < "/proc/$1/environ"
}

mcd() {
    [[ -n "$1" ]] && mkdir -p "$1" && cd "$1" || true
}
compdef _mkdir mcd  # https://github.com/robbyrussell/oh-my-zsh/issues/1895

df() {
    command -p df -h | awk 'NR == 1 || /sd|vd|nvme|mmcblk/'
}

# ex - archive extractor. usage: ex <file>
ex() {
    if [[ ! -f "$1" ]]; then
        echo "'$1' is not a valid file"
        return
    fi
    case "$1" in
        *.tar.bz2) tar xjf "$1"   ;;
        *.tar.gz)  tar xzf "$1"   ;;
        *.tar.xz)  tar xJf "$1"   ;;
        *.lzma)    unlzma "$1"    ;;
        *.bz2)     bunzip2 "$1"   ;;
        *.rar)     unrar x "$1"   ;;
        *.gz)      gunzip "$1"    ;;
        *.tar)     tar xf "$1"    ;;
        *.tbz2)    tar xjf "$1"   ;;
        *.tgz)     tar xzf "$1"   ;;
        *.zip)     unzip "$1"     ;;
        *.Z)       uncompress "$1";;
        *.7z)      7z x "$1"      ;;
        *)         echo "'$1' cannot be extracted via ex()";;
    esac
}

colors() {
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
