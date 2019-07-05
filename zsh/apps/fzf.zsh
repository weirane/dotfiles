fzf1=/usr/share/fzf

if [[ -f $fzf1/key-bindings.zsh && -f $fzf1/completion.zsh ]]; then
    . $fzf1/key-bindings.zsh
    . $fzf1/completion.zsh
elif [[ -f ~/.fzf.zsh ]]; then
    . ~/.fzf.zsh
fi
unset fzf1

if command -v fd >/dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type file --hidden --exclude .git/ --color=always'
    export FZF_DEFAULT_OPTS='--ansi'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi
