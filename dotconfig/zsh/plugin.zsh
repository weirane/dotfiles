# powerlevel10k
p10k=/usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
if [[ -f $p10k ]]; then
    . $p10k
    . $ZDOTDIR/.p10k.zsh
else
    PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
fi

# fast-syntax-highlighting
fsh=/usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
if [[ -f $fsh ]]; then
    . $fsh
fi
unset p10k fsh

# dotenv
source_env() {
    if ! [[ -f .env ]]; then
        return
    fi
    local confirm
    echo -n "dotenv: found '.env' file. Source it? ([Y]es/[n]o) "
    read -k 1 confirm
    [[ $confirm != $'\n' ]] && echo
    [[ $confirm == [nN] ]] && return

    # test .env syntax
    zsh -fn .env || echo "dotenv: error when sourcing '.env' file" >&2

    setopt localoptions allexport
    source .env
}

autoload -U add-zsh-hook
add-zsh-hook chpwd source_env

source_env
