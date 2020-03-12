# helper scripts and binaries
prependpath "$HOME/bin"
prependpath "$HOME/scripts"

# cargo
prependpath "$HOME/.cargo/bin"

# neovim
if command -v nvim >/dev/null; then
    export EDITOR=nvim
    alias vi='command vim'
    alias vim='nvim'
    alias vimdiff='nvim -d'
else
    export EDITOR=vim
fi

# exa
if command -v exa >/dev/null; then
    alias ls='exa'
    alias ll='exa -lgh'
    alias la='exa -lagh'

    EXA_COLORS=$(cat "$HOME/.dotfiles/exa_colors")
    export EXA_COLORS
fi

# fzf
fzf1=/usr/share/fzf

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --ansi"
if [ -f $fzf1/key-bindings.zsh ] && [ -f $fzf1/completion.zsh ]; then
    . $fzf1/key-bindings.zsh
    . $fzf1/completion.zsh
elif [ -f ~/.fzf.zsh ]; then
    . ~/.fzf.zsh
fi
unset fzf1

if command -v fd >/dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type file --hidden --exclude .git/ --color=always'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# ripgrep
export RIPGREP_CONFIG_PATH=$HOME/.config/ripgreprc

# ipython
export IPYTHONDIR="$HOME/.config/ipython"

# wget
export WGETRC="$HOME/.config/wgetrc"

# npm
export npm_config_cache="$HOME/.cache/npm"