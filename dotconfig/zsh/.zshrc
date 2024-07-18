. $ZDOTDIR/basic.zsh
. $ZDOTDIR/bindkey.zsh
. $ZDOTDIR/completion.zsh
. $ZDOTDIR/aliases.zsh
. $ZDOTDIR/functions.zsh
. $ZDOTDIR/apps.zsh
. $ZDOTDIR/plugin.zsh

[[ -f ~/.dotfiles/local/zshrc ]] && \. ~/.dotfiles/local/zshrc || true

if (( BEANMODE )); then
    unset BEANMODE
    cd $HOME/Documents/Beancount
    fava main.bean >/dev/null 2>&1 &
    thismonth
fi
