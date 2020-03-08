export ZSH="$HOME/.oh-my-zsh"

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
    cargo
    rust
    colored-man-pages
    # zsh-autosuggestions
    zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh
unset plugins

eval $(dircolors -b ~/.dotfiles/dir_colors)
