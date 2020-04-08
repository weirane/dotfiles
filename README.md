# dotfiles
My configs for vim, zsh, i3, polybar etc.

## Setup
Some of the steps below are covered by `./setup.sh`.

### Zsh
Install `zsh` via `pacman`, or [from source][zsh-src]. Running `./setup.sh` will install [oh-my-zsh], [spaceship prompt] and [zsh-syntax-highlighting].

[zsh-src]: https://github.com/zsh-users/zsh/blob/master/INSTALL
[oh-my-zsh]: https://github.com/robbyrussell/oh-my-zsh
[spaceship prompt]: https://github.com/denysdovhan/spaceship-prompt
[zsh-syntax-highlighting]: https://github.com/zsh-users/zsh-syntax-highlighting

### Command line utilities
- [**exa**][exa]: install via `pacman` or download [prebuilt binaries][exa-bin]
- [**ripgrep**][rg]: install via `pacman` or download [prebuilt binaries][rg-bin]
- [**fd**][fd]: install via `pacman` or download [prebuilt binaries][fd-bin]
- [**fzf**][fzf]: install via `pacman` or [`git`][fzf-git]:
    ```sh
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
    ```
- [**autojump**][autojump]: install via `pacman` or manually:
    ```sh
    git clone https://github.com/wting/autojump.git
    cd autojump
    ./install.py
    ```

On Arch:
```sh
sudo pacman -S exa ripgrep fd fzf autojump
```

Note: `autojump` is not in the standard repository, but you can find it in [archlinuxcn].

[exa]: https://github.com/ogham/exa
[exa-bin]: https://github.com/ogham/exa/releases
[rg]: https://github.com/BurntSushi/ripgrep
[rg-bin]: https://github.com/BurntSushi/ripgrep/releases
[fd]: https://github.com/sharkdp/fd
[fd-bin]: https://github.com/sharkdp/fd/releases
[fzf]: https://github.com/junegunn/fzf
[fzf-git]: https://github.com/junegunn/fzf#using-git
[autojump]: https://github.com/wting/autojump
[archlinuxcn]: https://lug.ustc.edu.cn/wiki/mirrors/help/archlinuxcn

### scripts
Some of the bindings I have use external shell scripts, which can be found in [this GitHub repo][scripts-repo]. Installation of the scripts is covered by `./setup.sh`.

[scripts-repo]: https://github.com/weirane/scripts

### Neovim
Install [`neovim`][nvim] via `pacman` or download the [prebuilt package][nvim-bin], and install python package `pynvim` and node.js package `neovim` (these two are optional).

    sudo pacman -S nvim python-pynvim
    npm install -g neovim

Plugin manager [vim-plug] can be downloaded using the script `./setup.sh`. Run `:PlugInstall` to install plugins.

[nvim]: https://github.com/neovim/neovim
[nvim-bin]: https://github.com/neovim/neovim/releases
[vim-plug]: https://github.com/junegunn/vim-plug

#### coc.nvim
[coc.nvim] is for auto completing and linting. Run the following command in vim to install additional components.

    :CocInstall coc-python coc-tsserver coc-rls coc-vimtex coc-diagnostic coc-css coc-html coc-json coc-prettier

For python linting, install `flake8` via `pip` or `pacman`.

[coc.nvim]: https://github.com/neoclide/coc.nvim

#### Other Vim plugins
| Vim plugin           | Dependencies | Notes                         |
|:--------------------:|:------------:|:-----------------------------:|
| [`python-mode`]      | [ipdb]       | install via `pip` or `pacman` |


[`python-mode`]: https://github.com/python-mode/python-mode
[ipdb]: https://pypi.org/project/ipdb/
[`vim-autopep8`]: https://github.com/tell-k/vim-autopep8
[autopep8]: https://github.com/hhatto/autopep8#installation
[`vim-clang-format`]: https://github.com/rhysd/vim-clang-format

### Map Caps Lock to Escape and Ctrl
Install two AUR packages and enable `udevmon`:

    yay -S interception-tools interception-caps2esc-nocaps-git
    sudo cp ./etc/udevmon.yaml /etc/udevmon.yaml
    sudo systemctl enable --now udevmon

Related blog post (zh_CN): [link](https://weirane.github.io/2020/04/map-capslock-to-esc-and-ctrl.html)
