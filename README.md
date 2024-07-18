# dotfiles

My configs for vim, zsh, yabai, skhd, sketchybar, etc. on macOS.

For Linux dotfiles, see the `master` branch.

## Setup

Execute `./setup.sh` to symlink config files in home and `~/.config`.

### Command line utilities

```sh
brew install eza ripgrep fd bat fzf
```

### scripts

Some of the bindings I have use external shell scripts, which can be found in
[this GitHub repo][scripts-repo]. Installation of the scripts is covered by
`./setup.sh`. Make sure to use the `macos` branch.

[scripts-repo]: https://github.com/weirane/scripts

### Neovim

Install

```sh
brew install neovim
```

Plugin manager [vim-plug] can be downloaded using the script `./setup.sh`. Run
`:PlugInstall` to install plugins.

[nvim]: https://github.com/neovim/neovim
[nvim-bin]: https://github.com/neovim/neovim/releases
[vim-plug]: https://github.com/junegunn/vim-plug

#### coc.nvim

Run in vim to install additional [coc.nvim] components:

    :CocInstall coc-jedi coc-tsserver coc-rust-analyzer coc-vimtex coc-diagnostic coc-css coc-html coc-json coc-prettier coc-vimlsp coc-word

For python linting and formatting, install `flake8` and `autopep8` via `brew`.

[coc.nvim]: https://github.com/neoclide/coc.nvim

### Map Caps Lock to Escape and Ctrl

Use Karabiner (`brew install --cask karabiner-elements`), then add a complex modification:
```json
{
    "description": "tap caps for esc, hold for ctrl",
    "manipulators": [
        {
            "from": {
                "key_code": "left_control",
                "modifiers": {
                    "optional": [
                        "any"
                    ]
                }
            },
            "to": [
                {
                    "key_code": "left_control",
                    "lazy": true
                }
            ],
            "to_if_alone": [
                {
                    "key_code": "escape"
                }
            ],
            "type": "basic"
        }
    ]
}
```
