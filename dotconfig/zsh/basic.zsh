export LANG=en_US.UTF-8
export LC_TIME=en_GB.UTF-8
export ZSH="$HOME/.local/share/oh-my-zsh"

PROMPT_EOL_MARK="%B%F{8}↵%f%b"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
DISABLE_MAGIC_FUNCTIONS="true"
# ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
    dotenv
    rust
    # zsh-autosuggestions
    fast-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh
unset plugins

# toggle sudo with esc-esc
sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
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
    [[ -z $BUFFER ]] && zle up-history
    local -a bufarr
    bufarr=(${(z)BUFFER})
    # ignore if there is only one word
    [[ ${#bufarr[@]} > 1 ]] && bufarr=(${bufarr[@]:1})
    BUFFER=" $bufarr"
    zle beginning-of-line
}
zle -N replace-command-name
bindkey '^[ ' replace-command-name

bindkey '^U' backward-kill-line
bindkey '^[l' vi-find-next-char
bindkey '^[h' vi-find-prev-char
bindkey '^[;' vi-repeat-find
bindkey '^[,' vi-rev-repeat-find
bindkey '^[H' run-help
bindkey '^[p' up-line-or-beginning-search
bindkey '^[n' down-line-or-beginning-search

cdpath=(~ ..)
SAVEHIST=99999999
WORDCHARS="-"

zstyle ':completion:*:cd:*' ignore-parents parent pwd

setopt rc_quotes  # '' as ' in single quotes
setopt extendedglob

unalias run-help
autoload -Uz run-help
autoload -Uz zcalc

compdef _pids cmdof
compdef _pids envof
