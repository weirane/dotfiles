bindkey -e
autoload -U up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey_if_exists() {
    (( $+terminfo[$1] )) && bindkey "${terminfo[$1]}" $2
}

bindkey_if_exists khome beginning-of-line             # Home
bindkey_if_exists kend end-of-line                    # End
bindkey_if_exists kpp up-line-or-history              # PageUp
bindkey_if_exists knp down-line-or-history            # PageDown
bindkey_if_exists kcuu1 up-line-or-beginning-search   # Up-Arrow
bindkey_if_exists kcud1 down-line-or-beginning-search # Down-Arrow
bindkey_if_exists kcbt reverse-menu-complete          # Shift-Tab
bindkey_if_exists kdch1 delete-char                   # Delete
bindkey '^?' backward-delete-char                     # Backspace

unfunction bindkey_if_exists

bindkey '^U' backward-kill-line
bindkey '^[l' vi-find-next-char
bindkey '^[h' vi-find-prev-char
bindkey '^[;' vi-repeat-find
bindkey '^[,' vi-rev-repeat-find
bindkey '^[H' run-help
bindkey '^[p' up-line-or-beginning-search
bindkey '^[n' down-line-or-beginning-search

# toggle sudo with esc-esc
sudo-command-line() {
    [[ -z ${BUFFER// } ]] && zle up-history
    local -a bufarr
    bufarr=(${(z)BUFFER})
    if [[ ${bufarr[1]} != sudo ]]; then
        bufarr=(sudo $bufarr)
    else
        bufarr=(${bufarr[@]:1})
    fi
    BUFFER=$bufarr
    zle end-of-line
}
zle -N sudo-command-line
bindkey '^[^[' sudo-command-line

# replace the first word of the current command
replace-command-name() {
    [[ -z ${BUFFER// } ]] && zle up-history
    local -a bufarr
    bufarr=(${(z)BUFFER})
    # ignore if there is only one word
    [[ ${#bufarr[@]} > 1 ]] && bufarr=(${bufarr[@]:1})
    BUFFER=" $bufarr"
    zle beginning-of-line
}
zle -N replace-command-name
bindkey '^[ ' replace-command-name
