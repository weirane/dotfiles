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

# dotenv
source_env() {
    if ! [[ -f .env ]]; then
        return
    fi
    # check blacklist
    if [[ -f $HOME/.config/dotenv/blacklist ]] && grep -q $PWD $HOME/.config/dotenv/blacklist; then
        return
    fi
    # check whitelist
    if [[ -f $HOME/.config/dotenv/whitelist ]] && grep -q $PWD $HOME/.config/dotenv/whitelist; then
        noconfirm=1
    fi
    if ! (( noconfirm )); then
        local confirm
        echo -n "dotenv: found '.env' file. Source it? ([Y]es/[n]o) "
        read -k 1 confirm
        [[ $confirm != $'\n' ]] && echo
        [[ $confirm == [nN] ]] && return
    fi

    # test .env syntax
    zsh -fn .env || echo "dotenv: error when sourcing '.env' file" >&2

    setopt localoptions allexport
    source .env
}

autoload -U add-zsh-hook
add-zsh-hook chpwd source_env

source_env
