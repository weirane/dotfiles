# dotfiles

My configs for vim, zsh, i3, polybar etc on Linux.

For macOS dotfiles, see the `macos` branch.

## TL;DR for desktop setup on Arch Linux

Setup [archlinuxcn] and run:

```sh
sudo pacman -S --needed base-devel zsh
./setup.sh
logout
# **Login again**
. /usr/share/nvm/nvm.sh
nvm install --lts
npm install -g neovim
```

Run in vim:

```
:PlugInstall
:CocInstall coc-jedi coc-tsserver coc-rust-analyzer coc-vimtex coc-diagnostic coc-css coc-html coc-json coc-prettier coc-vimlsp coc-word
```

Then check the optional dependencies of `weirane-dotfiles-deps-cli` and
`weriane-dotfiles-deps-gui`.

[archlinuxcn]: https://lug.ustc.edu.cn/wiki/mirrors/help/archlinuxcn

## Setup

Some of the steps below are covered by `./setup.sh`.

### Zsh

Install `zsh` with a package manager or [from source][zsh-src]. Running
`./setup.sh` will install [powerlevel10k] and [fast-syntax-highlighting].

[zsh-src]: https://github.com/zsh-users/zsh/blob/master/INSTALL
[oh-my-zsh]: https://github.com/robbyrussell/oh-my-zsh
[powerlevel10k]: https://github.com/romkatv/powerlevel10k
[fast-syntax-highlighting]: https://github.com/zdharma/fast-syntax-highlighting

### Command line utilities

| name      | manual install                |
|-----------|-------------------------------|
| [exa]     | [prebuilt binaries][exa-bin]  |
| [ripgrep] | [prebuilt binaries][rg-bin]   |
| [fd]      | [prebuilt binaries][fd-bin]   |
| [bat]     | [prebuilt binaries][bat-rel]  |
| [fzf]     | [install with `git`][fzf-git] |

[exa]: https://github.com/ogham/exa
[exa-bin]: https://github.com/ogham/exa/releases
[ripgrep]: https://github.com/BurntSushi/ripgrep
[rg-bin]: https://github.com/BurntSushi/ripgrep/releases
[fd]: https://github.com/sharkdp/fd
[fd-bin]: https://github.com/sharkdp/fd/releases
[bat]: https://github.com/sharkdp/bat
[bat-rel]: https://github.com/sharkdp/bat/releases
[fzf]: https://github.com/junegunn/fzf
[fzf-git]: https://github.com/junegunn/fzf#using-git

### scripts

Some of the bindings I have use external shell scripts, which can be found in
[this GitHub repo][scripts-repo]. Installation of the scripts is covered by
`./setup.sh`.

[scripts-repo]: https://github.com/weirane/scripts

### Neovim

Install

- [`neovim`][nvim] with a package manager or download the [prebuilt package][nvim-bin]
- python package `pynvim`
- node.js package `neovim`

Plugin manager [vim-plug] can be downloaded using the script `./setup.sh`. Run
`:PlugInstall` to install plugins.

[nvim]: https://github.com/neovim/neovim
[nvim-bin]: https://github.com/neovim/neovim/releases
[vim-plug]: https://github.com/junegunn/vim-plug

#### coc.nvim

Run in vim to install additional [coc.nvim] components:

    :CocInstall coc-jedi coc-tsserver coc-rust-analyzer coc-vimtex coc-diagnostic coc-css coc-html coc-json coc-prettier coc-vimlsp coc-word

For python linting, install `flake8` via `pip`.

[coc.nvim]: https://github.com/neoclide/coc.nvim

#### Other Vim plugins

| Vim plugin      | Dependencies | Notes              |
|:---------------:|:------------:|:------------------:|
| [`python-mode`] | [ipdb]       | install with `pip` |


[`python-mode`]: https://github.com/python-mode/python-mode
[ipdb]: https://pypi.org/project/ipdb/
[`vim-autopep8`]: https://github.com/tell-k/vim-autopep8
[autopep8]: https://github.com/hhatto/autopep8#installation
[`vim-clang-format`]: https://github.com/rhysd/vim-clang-format

### Map Caps Lock to Escape and Ctrl

Only map in X, use [XCAPE] with Xmodmap.

```bash
xcape -e 'Control_L=Escape'  # rerun at startup
```

To map also in tty, install two AUR packages and enable `udevmon`:

    yay -S interception-tools interception-caps2esc-nocaps-git
    sudo cp ./etc/udevmon.yaml /etc/udevmon.yaml
    sudo systemctl enable --now udevmon

Related blog post (zh_CN): [link][blog-caps]

[XCAPE]: https://github.com/alols/xcape
[blog-caps]: https://weirane.github.io/2020/04/map-capslock-to-esc-and-ctrl.html
