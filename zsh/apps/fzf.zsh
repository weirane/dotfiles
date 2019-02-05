fzf1=/usr/share/fzf
fzf2=~/.fzf/shell

kb=key-bindings.zsh
cp=completion.zsh

if [[ -f $fzf1/$kb && -f $fzf1/$cp ]]; then
	. $fzf1/key-bindings.zsh
	. $fzf1/completion.zsh
elif [[ -f $fzf2/$kb && -f $fzf2/$cp ]]; then
	. $fzf2/key-bindings.zsh
	. $fzf2/completion.zsh
fi

unset fzf1 fzf2 kb cp
