# homebrew
export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
export HOMEBREW_REPOSITORY="/opt/homebrew"
export HOMEBREW_NO_ENV_HINTS=1

prependpath /opt/homebrew/sbin
prependpath /opt/homebrew/bin

# gnu utils
[[ $PATH =~ /libexec/gnubin ]] || path=(/opt/homebrew/opt/*/libexec/gnubin $path)

# helper scripts and binaries
prependpath $HOME/scripts
prependpath $HOME/bin

# mise
eval "$(mise activate)"

# rust
export RUSTUP_HOME="$HOME/.local/share/rustup"
export CARGO_HOME="$HOME/.local/share/cargo"
prependpath /opt/homebrew/opt/rustup/bin
prependpath $CARGO_HOME/bin
export CARGO_TARGET_DIR=$HOME/.cache/cargo-target

# neovim
if (( $+commands[nvim] )); then
    export EDITOR=nvim
    alias vim='nvim'
    alias vimdiff='nvim -d'
    export MANPAGER="nvim +Man!"
else
    export EDITOR=vim
fi

# eza
if (( $+commands[eza] )); then
    alias ls='eza'
    alias ll='eza -lgh'
    alias la='eza -lagh'

    EZA_COLORS=$(<$HOME/.dotfiles/eza_colors)
    export EZA_COLORS
    zstyle ':completion:*' list-colors "${(@s.:.)EZA_COLORS}"
else
    eval "$(dircolors -b ~/.dotfiles/dir_colors)"
    zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
fi

# fzf
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --ansi"
fzf1=/opt/homebrew/opt/fzf/shell
[[ -f $fzf1/key-bindings.zsh ]] && . $fzf1/key-bindings.zsh
[[ -f $fzf1/completion.zsh ]] && . $fzf1/completion.zsh
unset fzf1

if (( $+commands[fd] )); then
    export FZF_DEFAULT_COMMAND='fd --type file --hidden --exclude .git/ --color=always'
    export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
fi

# zoxide
eval "$(zoxide init zsh --no-cmd)"
j() {
    __zoxide_z "$@"
}
ji() {
    __zoxide_zi "$@"
}

# less
export LESS="-MR --mouse --wheel-lines=3 -# 10"

# ruby
export IRBRC="$HOME/.config/irb/irbrc"
export GEM_HOME="$HOME/.local/share/gem"
export GEM_SPEC_CACHE="$HOME/.cache/gem"
export SOLARGRAPH_CACHE="$HOME/.cache/solargraph"
export BUNDLE_USER_CACHE="$HOME/.cache/bundle"
export BUNDLE_USER_CONFIG="$HOME/.config/bundle"
export BUNDLE_USER_PLUGIN="$HOME/.local/share/bundle"

# XDG
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

export npm_config_cache="$HOME/.cache/npm"
export VIMINIT="source $HOME/.config/nvim/init.vim"
export LESSHISTFILE="$HOME/.cache/lesshst"
export WGETRC="$HOME/.config/wgetrc"
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgreprc"
export IPYTHONDIR="$HOME/.config/ipython"
export JUPYTER_CONFIG_DIR="$HOME/.config/jupyter"
export HTTPIE_CONFIG_DIR="$HOME/.config/httpie"
export MYSQL_HISTFILE="$HOME/.cache/mysql_history"
export MYCLI_HISTFILE="$HOME/.cache/mycli-history"
export SQLITE_HISTORY="$HOME/.cache/sqlite_history"

# export TEXMFHOME="$XDG_DATA_HOME/texmf"
# export TEXMFVAR="$XDG_DATA_HOME/texlive/texmf-var"
# export TEXMFCONFIG="$XDG_DATA_HOME/texlive/texmf-config"
