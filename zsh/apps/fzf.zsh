fzf1=/usr/share/fzf

if [[ -f $fzf1/key-bindings.zsh && -f $fzf1/completion.zsh ]]; then
	. $fzf1/key-bindings.zsh
	. $fzf1/completion.zsh
elif [[ -f ~/.fzf.zsh ]]; then
	. ~/.fzf.zsh
fi
unset fzf1
