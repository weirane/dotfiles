export PATH="$HOME/bin:$HOME/scripts:$PATH"
export EDITOR="nvim"
export BROWSER="firefox"
export TERMINAL="alacritty"

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"

export LESSHISTFILE="$XDG_CACHE_HOME/lesshst"
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME/notmuch-config"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/settings.ini"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
systemctl --user import-environment \
    PATH EDITOR BROWSER TERMINAL \
    XDG_CACHE_HOME XDG_CONFIG_HOME XDG_DATA_HOME XAUTHORITY \
    LESSHISTFILE WGETRC NOTMUCH_CONFIG GTK2_RC_FILES PASSWORD_STORE_DIR

export NVM_DIR="$XDG_DATA_HOME/nvm"
[[ -f /usr/share/nvm/nvm.sh ]] && . /usr/share/nvm/nvm.sh

export TASKDATA="$XDG_DATA_HOME/task"
export TASKRC="$XDG_CONFIG_HOME/taskrc"
export npm_config_cache="$XDG_CACHE_HOME/npm"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export TEXMFHOME="$XDG_DATA_HOME/texmf"
export TEXMFVAR="$XDG_DATA_HOME/texlive/texmf-var"
export TEXMFCONFIG="$XDG_DATA_HOME/texlive/texmf-config"
export WEECHAT_HOME="$XDG_CONFIG_HOME/weechat"

export VIMINIT="source $XDG_CONFIG_HOME/nvim/init.vim"

[[ "$(tty)" == "/dev/tty1" ]] &&
    ! pgrep -x Xorg >/dev/null &&
    (( $+commands[startx] )) &&
    [[ -f $HOME/.config/X11/xinitrc ]] &&
    exec startx $HOME/.config/X11/xinitrc
