#!/bin/bash
if [[ ! -d ~/.dotfiles ]]; then
	echo cannot find dotfiles dir
	exit 1
fi

set -x
for f in ~/.dotfiles/symlinks/*; do
	home_name=~/.$(basename $f)
	[[ -f $home_name ]] || ln -s $f $home_name
done

# .vim
[[ -d ~/.vim/ftplugin ]] || ln -s ~/.dotfiles/vim/dotvim/ftplugin ~/.vim/ftplugin
[[ -d ~/.vim/ftdetect ]] || ln -s ~/.dotfiles/vim/dotvim/ftdetect ~/.vim/ftdetect
[[ -d ~/.vim/syntax ]] || ln -s ~/.dotfiles/vim/dotvim/syntax ~/.vim/syntax
[[ -d ~/.vim/after ]] || ln -s ~/.dotfiles/vim/dotvim/after ~/.vim/after

exit 0
