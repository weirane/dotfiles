(( TASKMODE )) && task

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

. $ZDOTDIR/basic.zsh
. $ZDOTDIR/completion.zsh
. $ZDOTDIR/aliases.zsh
. $ZDOTDIR/functions.zsh
. $ZDOTDIR/apps.zsh
. $ZDOTDIR/.p10k.zsh

[[ -f ~/.dotfiles/local/zshrc ]] && \. ~/.dotfiles/local/zshrc || true

if (( TASKMODE )); then
    unset TASKMODE
    zle-line-init() {
        [[ -n $BUFFER ]] || BUFFER=' task '
        zle end-of-line
    }
fi
