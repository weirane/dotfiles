#!/bin/sh
if [ ! -d "$HOME/.dotfiles" ]; then
    echo "Cannot find dotfiles dir."
    exit 1
fi

set -e

echodo() {
    set -x
    "$@"
    { set +x; } 2>/dev/null
}

confirm() {
    printf "%s (y/N) " "${1:-Are you sure?}"
    read -r response
    case $(echo "$response" | tr A-Z a-z) in
        yes | y) true ;;
        *) false ;;
    esac
}

confirmy() {
    printf "%s (Y/n) " "${1:-Are you sure?}"
    read -r response
    case $(echo "$response" | tr A-Z a-z) in
        no | n) false ;;
        *) true ;;
    esac
}

# symlinks
for f in "$HOME"/.dotfiles/symlinks/*; do
    home_name="$HOME/.$(basename "$f")"
    [ -f "$home_name" ] || echodo ln -s "$f" "$home_name"
done

# .vim
[ -d "$HOME/.vim" ] || mkdir "$HOME/.vim"
[ -f "$HOME/.vim/vimrc" ] || echodo ln -s "$HOME/.dotfiles/vim/dotvim/vimrc" "$HOME/.vim/vimrc"
vimdirs="ftplugin ftdetect syntax after"
for dir in $vimdirs; do
    [ -d "$HOME/.vim/$dir" ] || echodo ln -s "$HOME/.dotfiles/vim/dotvim/$dir" "$HOME/.vim/$dir"
done

[ -d "$HOME/.dotfiles/local" ] || echodo mkdir -p "$HOME/.dotfiles/local"
[ -f "$HOME/.dotfiles/local/gdbinit" ] || echodo touch "$HOME/.dotfiles/local/gdbinit"

# .config
[ -d "$HOME/.config" ] || mkdir -p "$HOME/.config"
for d in "$HOME"/.dotfiles/dotconfig/*; do
    name="$HOME"/.config/$(basename "$d")
    [ -e "$name" ] || echodo ln -s "$d" "$name"
done

# vim-plug
if [ ! -f "$HOME"/.vim/autoload/plug.vim ] && confirm "Download plug.vim?"; then
    echodo curl -fLo "$HOME"/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

export ZSH="$HOME/.local/share/oh-my-zsh"
ZSH_CUSTOM="${ZSH_CUSTOM:-$ZSH/custom}"
# oh-my-zsh
if [ ! -d "$ZSH" ] && confirm "Setup oh-my-zsh?"; then
    tmpf=$(mktemp /tmp/.oh-my-zsh-XXXXXXX.sh)
    echodo curl -Lo "$tmpf" \
        https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
    less "$tmpf"
    if confirmy "Proceed?"; then
        echodo sh "$tmpf"
        echodo rm "$tmpf"
    fi
fi

# spaceship-prompt
if [ ! -d "$ZSH_CUSTOM/themes/spaceship-prompt" ] && confirm "Setup spaceship-prompt?"; then
    echodo git clone https://github.com/denysdovhan/spaceship-prompt.git \
        "$ZSH_CUSTOM/themes/spaceship-prompt"
    (cd "$ZSH_CUSTOM/themes" && echodo ln -s spaceship-prompt/spaceship.zsh-theme .)
fi

# zsh-syntax-highlight
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] && confirm "Setup zsh-syntax-highlighting?"; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# Helper shell scripts
if [ ! -d "$HOME/scripts" ] && confirm "Setup helper shell scripts?"; then
    printf "Clone using SSH(s) or HTTPS(h)? (H/s) "
    read -r proto
    if [ "$(echo "$proto" | tr A-Z a-z)" = s ]; then
        pre=git@github.com:
    else
        pre=https://github.com/
    fi
    git clone "${pre}weirane/scripts" "$HOME/scripts"
fi

exit 0
