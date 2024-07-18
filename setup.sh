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

[ "$1" = "-a" ] && do_all=1

# local
[ -d "$HOME/.dotfiles/local" ] || echodo mkdir -p "$HOME/.dotfiles/local"
# [ -f "$HOME/.dotfiles/local/gdbinit" ] || echodo touch "$HOME/.dotfiles/local/gdbinit"

# symlinks
for f in "$HOME"/.dotfiles/symlinks/*; do
    home_name="$HOME/.$(basename "$f")"
    [ -f "$home_name" ] || echodo ln -s "$f" "$home_name"
done

# .config
[ -d "$HOME/.config" ] || mkdir -p "$HOME/.config"
for d in "$HOME"/.dotfiles/dotconfig/*; do
    name="$HOME"/.config/$(basename "$d")
    [ -e "$name" ] || echodo ln -s "$d" "$name"
done

# prevent ~/.tig_history
[ -d "$HOME/.local/share/tig" ] || echodo mkdir -p "$HOME/.local/share/tig"

# vim-plug
if [ ! -f "$HOME/.config/nvim/autoload/plug.vim" ] && confirm "Download plug.vim?"; then
    echodo curl -fLo "$HOME/.config/nvim/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
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
    echodo git clone "${pre}weirane/scripts" "$HOME/scripts"
    echodo git -C "$HOME/scripts" checkout macos
fi

exit 0
