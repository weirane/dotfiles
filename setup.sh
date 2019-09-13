#!/bin/bash
if [[ ! -d ~/.dotfiles ]]; then
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

# symlinks
for f in ~/.dotfiles/symlinks/*; do
    home_name=~/.$(basename $f)
    [[ -f $home_name ]] || echodo ln -s $f $home_name
done

# .vim
[[ -d ~/.vim ]] || mkdir ~/.vim
vimdirs="ftplugin ftdetect syntax after"
for dir in $vimdirs; do
    [[ -d ~/.vim/$dir ]] || echodo ln -s ~/.dotfiles/vim/dotvim/$dir ~/.vim/$dir
done

[[ -d ~/.dotfiles/local ]] || echodo mkdir -p ~/.dotfiles/local
[[ -f ~/.dotfiles/local/gdbinit ]] || echodo touch ~/.dotfiles/local/gdbinit

if [[ ! -f ~/.vim/autoload/plug.vim ]] && confirm "Download plug.vim? (y/N)"; then
    echodo curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

exit 0
