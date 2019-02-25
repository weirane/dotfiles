#!/bin/bash
if [[ ! -d ~/.dotfiles ]]; then
	echo cannot find dotfiles dir
	exit 1
fi

echoln () {
	set -x
	ln "$@"
	{ set +x; } 2>/dev/null
}

for f in ~/.dotfiles/symlinks/*; do
	home_name=~/.$(basename $f)
	[[ -f $home_name ]] || ln -s $f $home_name
done

# .vim
[[ -d ~/.vim/ftplugin ]] || echoln -s ~/.dotfiles/vim/dotvim/ftplugin ~/.vim/ftplugin
[[ -d ~/.vim/ftdetect ]] || echoln -s ~/.dotfiles/vim/dotvim/ftdetect ~/.vim/ftdetect
[[ -d ~/.vim/syntax ]] || echoln -s ~/.dotfiles/vim/dotvim/syntax ~/.vim/syntax
[[ -d ~/.vim/after ]] || echoln -s ~/.dotfiles/vim/dotvim/after ~/.vim/after

exit 0
