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
[ -d "$HOME/.config/X11" ] || echodo mkdir "$HOME/.config/X11"
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
fi

# Set the login shell
curr_shell=$(awk -F: '$1 == ENVIRON["USER"] { print $NF }' /etc/passwd)
has_zsh=$(grep '/zsh$' /etc/shells | head -n 1 2>/dev/null)
if [ "${curr_shell##*/}" != zsh ] && [ -n "$has_zsh" ] && confirm "Set the login shell to $has_zsh?"; then
    echodo chsh -s "$has_zsh"
fi

if command -v pacman >/dev/null; then
    has_pkg() {
        pacman -Q "$1" >/dev/null 2>&1
    }
    # weirane-dotfiles-deps-{cli,gui}
    pkg=weirane-dotfiles-deps
    cd "$HOME/.dotfiles/$pkg"
    if ! has_pkg "$pkg-gui" && confirm "Setup $pkg-gui?"; then
        echodo makepkg -i
    elif ! has_pkg "$pkg-cli" && confirm "Setup $pkg-cli?"; then
        echodo makepkg -f
        sudo pacman -U "$(makepkg --packagelist | grep "$pkg-cli")"
    fi
    cd ..

    # powerlevel10k
    pkg=zsh-theme-powerlevel10k-git
    if ! has_pkg "$pkg" && confirm "Install $pkg?"; then
        echodo paru -S "$pkg"
    fi

    # fast-syntax-highlighting
    pkg=zsh-fast-syntax-highlighting-git
    if ! has_pkg "$pkg" && confirm "Install $pkg?"; then
        echodo paru -S "$pkg"
    fi
else
    # powerlevel10k
    p10k_dir=$HOME/.local/share/zsh/powerlevel10k
    if [ ! -d "$p10k_dir" ] && confirm "Setup powerlevel10k?"; then
        echodo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$p10k_dir"
    fi

    # fast-syntax-highlighting
    fsh_dir=$HOME/.local/share/zsh/fast-syntax-highlighting
    if [ ! -d "$fsh_dir" ] && confirm "Setup fast-syntax-highlighting?"; then
        echodo git clone --depth=1 https://github.com/zdharma-continuum/fast-syntax-highlighting.git "$fsh_dir"
    fi
fi

exit 0
