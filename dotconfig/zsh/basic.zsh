export ZSH="$HOME/.local/share/oh-my-zsh"

PROMPT_EOL_MARK="%B%F{8}↵%f%b"
HYPHEN_INSENSITIVE="true"
DISABLE_MAGIC_FUNCTIONS="true"
# ZSH_THEME="robbyrussell"
ZSH_THEME="spaceship"

SPACESHIP_TIME_SHOW="true"
SPACESHIP_EXIT_CODE_SHOW="true"
SPACESHIP_EXIT_CODE_SYMBOL=""
SPACESHIP_EXIT_CODE_SUFFIX="|"
SPACESHIP_PROMPT_ORDER=(
    time user dir host git venv exec_time line_sep
    jobs exit_code char
)

plugins=(
    autojump
    dotenv
    rust
    # zsh-autosuggestions
    fast-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh
unset plugins

eval $(dircolors -b ~/.dotfiles/dir_colors)

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

zstyle ':completion:*:cd:*' ignore-parents parent pwd

setopt rc_quotes  # '' as ' in single quotes
