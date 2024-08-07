# powerlevel10k
p10k=/opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
[[ -f $p10k ]] || p10k=$HOME/.local/share/zsh/powerlevel10k/powerlevel10k.zsh-theme
if [[ -f $p10k ]]; then
    . $p10k
    . $ZDOTDIR/.p10k.zsh
else
    PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
fi

# fast-syntax-highlighting
fsh=/opt/homebrew/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
[[ -f $fsh ]] || fsh=$HOME/.local/share/zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
if [[ -f $fsh ]]; then
    . $fsh
fi
unset p10k fsh
# https://github.com/zdharma-continuum/fast-syntax-highlighting/issues/27
FAST_HIGHLIGHT[chroma-man]=
