export ZSH="$HOME/.oh-my-zsh"

HYPHEN_INSENSITIVE="true"
# ZSH_THEME="robbyrussell"
ZSH_THEME="spaceship"

SPACESHIP_TIME_SHOW="true"
SPACESHIP_PROMPT_ORDER=(
	time
	user
	dir
	host
	git
	venv
	exec_time
	line_sep
	battery
	jobs
	exit_code
	char
)

plugins=(
	autojump
	cargo
	# zsh-autosuggestions
	zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh

eval $(dircolors -b ~/.dotfiles/dir_colors)
