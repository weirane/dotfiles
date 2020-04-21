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
    time
    user
    dir
    host
    git
    venv
    exec_time
    line_sep
    jobs
    exit_code
    char
)

plugins=(
    autojump
    dotenv
    rust
    colored-man-pages
    # zsh-autosuggestions
    zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh
unset plugins

eval $(dircolors -b ~/.dotfiles/dir_colors)

bindkey '^[p' up-line-or-beginning-search
bindkey '^[n' down-line-or-beginning-search

cdpath=(~ ..)

zstyle ':completion:*:cd:*' ignore-parents parent pwd

setopt rc_quotes  # '' as ' in single quotes
