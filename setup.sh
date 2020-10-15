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
    [ "$do_all" = 1 ] && return 0
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

[ "$1" = "-a" ] && do_all=1

# symlinks
for f in "$HOME"/.dotfiles/symlinks/*; do
    home_name="$HOME/.$(basename "$f")"
    [ -f "$home_name" ] || echodo ln -s "$f" "$home_name"
done

[ -d "$HOME/.dotfiles/local" ] || echodo mkdir -p "$HOME/.dotfiles/local"
[ -f "$HOME/.dotfiles/local/gdbinit" ] || echodo touch "$HOME/.dotfiles/local/gdbinit"

# .config
[ -d "$HOME/.config" ] || mkdir -p "$HOME/.config"
for d in "$HOME"/.dotfiles/dotconfig/*; do
    name="$HOME"/.config/$(basename "$d")
    [ -e "$name" ] || echodo ln -s "$d" "$name"
done

# prevent ~/.tig_history
[ -d "$HOME/.local/share/tig" ] || echodo mkdir -p "$HOME/.local/share/tig"
[ -f "$HOME/.config/newsboat/ignores" ] || echodo touch "$HOME/.config/newsboat/ignores"

# vim-plug
if [ ! -f "$HOME/.config/nvim/autoload/plug.vim" ] && confirm "Download plug.vim?"; then
    echodo curl -fLo "$HOME/.config/nvim/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# *.desktop files
applications="$HOME/.local/share/applications"
added=0
[ -d "$applications" ] || echodo mkdir -p "$applications"
for f in "$HOME"/.dotfiles/applications/*; do
    name="$HOME/.local/share/applications/$(basename "$f")"
    [ -f "$name" ] || { echodo ln -s "$f" "$name" && added=1; }
done
[ "$added" = 1 ] && update-desktop-database "$applications" 2>/dev/null || true

export ZSH="$HOME/.local/share/oh-my-zsh"
ZSH_CUSTOM="${ZSH_CUSTOM:-$ZSH/custom}"
# oh-my-zsh
if [ ! -d "$ZSH" ] && confirm "Setup oh-my-zsh?"; then
    tmpf=$(mktemp /tmp/.oh-my-zsh-XXXXXXX.sh)
    echodo curl -Lo "$tmpf" \
        https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
    less "$tmpf"
    if confirmy "Proceed?"; then
        echodo chmod +x "$tmpf"
        echodo env RUNZSH=no "$tmpf"
        echodo rm "$tmpf"
        echodo rm -f "$HOME/.shell.pre-oh-my-zsh" "$HOME/.zshrc"
    fi
fi

# powerlevel10k
p10k_dir=$ZSH_CUSTOM/themes/powerlevel10k
if [ -d "$ZSH" ] && [ ! -d "$p10k_dir" ] && confirm "Setup powerlevel10k?"; then
    echodo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$p10k_dir"
fi

# fast-syntax-highlighting
fsh_dir=$ZSH_CUSTOM/plugins/fast-syntax-highlighting
if [ -d "$ZSH" ] && [ ! -d "$fsh_dir" ] && confirm "Setup fast-syntax-highlighting?"; then
    git clone --depth=1 https://github.com/zdharma/fast-syntax-highlighting.git "$fsh_dir"
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
