if (( TASKMODE )); then
    unset TASKMODE
    task
    autoload -Uz add-zle-hook-widget
    zle-task-line-init() {
        [[ -n $BUFFER ]] || BUFFER=' task '
        zle end-of-line
    }
    zle -N zle-task-line-init
    add-zle-hook-widget -Uz zle-line-init zle-task-line-init
fi

. $ZDOTDIR/basic.zsh
. $ZDOTDIR/bindkey.zsh
. $ZDOTDIR/completion.zsh
. $ZDOTDIR/aliases.zsh
. $ZDOTDIR/functions.zsh
. $ZDOTDIR/apps.zsh
. $ZDOTDIR/plugin.zsh

[[ -f ~/.dotfiles/local/zshrc ]] && \. ~/.dotfiles/local/zshrc || true
