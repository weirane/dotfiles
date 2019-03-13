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
	[[ -f $home_name ]] || echoln -s $f $home_name
done

# .vim
vimdirs="ftplugin ftdetect syntax after"
for dir in $vimdirs; do
	[[ -d ~/.vim/$dir ]] || echoln -s ~/.dotfiles/vim/dotvim/$dir ~/.vim/$dir
done

exit 0
