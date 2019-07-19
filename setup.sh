#!/bin/bash
if [[ ! -d ~/.dotfiles ]]; then
    echo cannot find dotfiles dir
    exit 1
fi

echodo () {
    set -x
    "$@"
    { set +x; } 2>/dev/null
}

for f in ~/.dotfiles/symlinks/*; do
    home_name=~/.$(basename $f)
    [[ -f $home_name ]] || echodo ln -s $f $home_name
done

# .vim
vimdirs="ftplugin ftdetect syntax after"
for dir in $vimdirs; do
    [[ -d ~/.vim/$dir ]] || echodo ln -s ~/.dotfiles/vim/dotvim/$dir ~/.vim/$dir
done

[[ -d ~/.dotfiles/local ]] || echodo mkdir -p ~/.dotfiles/local
[[ -f ~/.dotfiles/local/gdbinit ]] || echodo touch ~/.dotfiles/local/gdbinit

exit 0
