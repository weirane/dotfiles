# dotfiles
My dotfiles

## Dependencies
### fzf (recommended)
Install [fzf][fzf] via `pacman` or [`git`][fzf-git].

[fzf]: https://github.com/junegunn/fzf
[fzf-git]: https://github.com/junegunn/fzf#using-git

### Zsh
Install [oh-my-zsh][omz], [spaceship prompt][spaceship] and [zsh-syntax-highlighting][zsh-highlight].

[omz]: https://github.com/robbyrussell/oh-my-zsh
[spaceship]: https://github.com/denysdovhan/spaceship-prompt#oh-my-zsh
[zsh-highlight]: https://github.com/zsh-users/zsh-syntax-highlighting

### Vim
The desireable version of vim is `>= 8.1` with `+python3` and `-python` in the output of `vim --version`. Plugin [`python-mode`][python-mode] might not work well with `+python`.

Below is how I install my vim.
```bash
git clone git@github.com:vim/vim.git && cd vim
./configure --with-features=huge \
    --enable-multibyte --enable-python3interp=yes \
    --with-python3-config-dir=/usr/lib/python3.7/config-3.7m-x86_64-linux-gnu \
    --enable-perlinterp=yes --enable-cscope \
    --enable-luainterp=yes
make
sudo make install
```

#### Vim plugins
| Vim plugin                     | Dependencies             | Notes                     |
|:------------------------------:|:------------------------:|:-------------------------:|
| [`vim-gutentags`][gutentags]   | [universal ctags][ctags] |                           |
| [`python-mode`][python-mode]   | [ipdb][ipdb]             | install via `pip`         |
| [`vim-autopep8`][vim-autopep8] | [autopep8][autopep8]     | install `pip` or `pacman` |


[python-mode]: https://github.com/python-mode/python-mode
[gutentags]: https://github.com/ludovicchabant/vim-gutentags
[ctags]: https://github.com/universal-ctags/ctags
[ipdb]: https://pypi.org/project/ipdb/
[vim-autopep8]: https://github.com/tell-k/vim-autopep8
[autopep8]: https://github.com/hhatto/autopep8
