# helper scripts and binaries
prependpath $HOME/scripts
prependpath $HOME/bin

# cargo
prependpath $CARGO_HOME/bin
export CARGO_TARGET_DIR=/var/cache/cargo-target

# neovim
if (( $+commands[nvim] )); then
    export EDITOR=nvim
    alias vim='nvim'
    alias vimdiff='nvim -d'
    export MANPAGER="nvim -c 'set ft=man' -"
else
    export EDITOR=vim
fi

# exa
if (( $+commands[exa] )); then
    alias ls='exa'
    alias ll='exa -lgh'
    alias la='exa -lagh'

    EXA_COLORS=$(<$HOME/.dotfiles/exa_colors)
    export EXA_COLORS
    zstyle ':completion:*' list-colors "${(@s.:.)EXA_COLORS}"
else
    eval "$(dircolors -b ~/.dotfiles/dir_colors)"
    zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
fi

# fzf
export FZF_COMPLETION_TRIGGER='``'
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --ansi"
fzf1=/usr/share/fzf
[[ -f $fzf1/key-bindings.zsh ]] && . $fzf1/key-bindings.zsh
[[ -f $fzf1/completion.zsh ]] && . $fzf1/completion.zsh
unset fzf1

if (( $+commands[fd] )); then
    export FZF_DEFAULT_COMMAND='fd --type file --hidden --exclude .git/ --color=always'
    export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
fi

# less
export LESS="-MR --mouse --wheel-lines=3 -# 10"
export SYSTEMD_LESS="-FRSXMK --mouse --wheel-lines=3 -# 10"

# ripgrep
export RIPGREP_CONFIG_PATH=$HOME/.config/ripgreprc

# ipython
export IPYTHONDIR="$HOME/.config/ipython"

# httpie
export HTTPIE_CONFIG_DIR="$HOME/.config/httpie"

# mysql, mycli, sqlite
export MYSQL_HISTFILE="$HOME/.cache/mysql_history"
export MYCLI_HISTFILE="$HOME/.cache/mycli-history"
export SQLITE_HISTORY="$HOME/.cache/sqlite_history"

# ruby, bundle
export IRBRC="$HOME/.config/irb/irbrc"
export GEM_HOME="$HOME/.local/share/gem"
export GEM_SPEC_CACHE="$HOME/.cache/gem"
export SOLARGRAPH_CACHE="$HOME/.cache/solargraph"
export BUNDLE_USER_CACHE="$HOME/.cache/bundle"
export BUNDLE_USER_CONFIG="$HOME/.config/bundle"
export BUNDLE_USER_PLUGIN="$HOME/.local/share/bundle"
