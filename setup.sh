#!/bin/sh
if [ ! -d $HOME/.dotfiles ]; then
    echo "Cannot find dotfiles dir."
    exit 1
fi

echodo () {
    set -x
    "$@"
    { set +x; } 2>/dev/null
}

confirm () {
    read -rp "${1:-Are you sure? [y/N]} " response
    case "${response,,}" in
        yes|y) true  ;;
        *)     false ;;
    esac
}

confirmy () {
    read -rp "${1:-Are you sure? [Y/n]} " response
    case "${response,,}" in
        no|n) false ;;
        *)    true  ;;
    esac
}

# symlinks
for f in $HOME/.dotfiles/symlinks/*; do
    home_name=$HOME/.$(basename $f)
    [ -f $home_name ] || echodo ln -s $f $home_name
done

# .vim
[ -d $HOME/.vim ] || mkdir $HOME/.vim
[ -f $HOME/.vim/vimrc ] || echodo ln -s $HOME/.dotfiles/vim/dotvim/vimrc $HOME/.vim/vimrc
vimdirs="ftplugin ftdetect syntax after"
for dir in $vimdirs; do
    [ -d $HOME/.vim/$dir ] || echodo ln -s $HOME/.dotfiles/vim/dotvim/$dir $HOME/.vim/$dir
done

[ -d $HOME/.dotfiles/local ] || echodo mkdir -p $HOME/.dotfiles/local
[ -f $HOME/.dotfiles/local/gdbinit ] || echodo touch $HOME/.dotfiles/local/gdbinit

# .config
for d in $HOME/.dotfiles/dotconfig/*; do
    name=$HOME/.config/$(basename $d)
    [ -e $name ] || echodo ln -s $d $name
done

# vim-plug
if [ ! -f $HOME/.vim/autoload/plug.vim ] && confirm "Download plug.vim? (y/N)"; then
    echodo curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
# oh-my-zsh
if [ ! -d $HOME/.oh-my-zsh ] && confirm "Setup oh-my-zsh? (y/N)"; then
    tmpf=$(mktemp /tmp/.oh-my-zsh-XXXXXXX.sh)
    echodo curl -Lo $tmpf \
        https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
    less $tmpf
    if confirmy "Proceed? (Y/n)"; then
        echodo sh $tmpf
        echodo rm $tmpf
    fi
fi

# spaceship-prompt
if [ ! -d $ZSH_CUSTOM/themes/spaceship-prompt ] \
        && confirm "Setup spaceship-prompt? (y/N)"; then
    echodo git clone https://github.com/denysdovhan/spaceship-prompt.git \
        "$ZSH_CUSTOM/themes/spaceship-prompt"
    echodo ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" \
        "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
fi

# zsh-syntax-highlight
if [ ! -d $ZSH_CUSTOM/plugins/zsh-syntax-highlighting ] \
        && confirm "Setup zsh-syntax-highlighting? (y/N)"; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

exit 0
