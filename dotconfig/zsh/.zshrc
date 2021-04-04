(( TASKMODE )) && task

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

. $ZDOTDIR/basic.zsh
. $ZDOTDIR/bindkey.zsh
. $ZDOTDIR/completion.zsh
. $ZDOTDIR/aliases.zsh
. $ZDOTDIR/functions.zsh
. $ZDOTDIR/apps.zsh
. $ZDOTDIR/plugin.zsh

[[ -f ~/.dotfiles/local/zshrc ]] && \. ~/.dotfiles/local/zshrc || true

if (( TASKMODE )); then
    unset TASKMODE
    autoload -Uz add-zle-hook-widget
    zle-task-line-init() {
        [[ -n $BUFFER ]] || BUFFER=' task '
        zle end-of-line
    }
    add-zle-hook-widget -Uz zle-line-init zle-task-line-init
fi
