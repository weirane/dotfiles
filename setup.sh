#!/bin/bash

if [[ ! -d ~/.dotfiles ]]; then
	echo cannot find dotfiles dir
	exit 1
fi

for f in ~/.dotfiles/symlinks/*; do
	home_name=~/.$(basename $f)
	[[ -f $home_name ]] || ln -s $f $home_name
done

exit 0
