# dotfiles

My configs for vim, zsh, yabai, skhd, sketchybar, etc. on macOS.

For Linux dotfiles, see the `master` branch.

## Setup

Execute `./setup.sh` to symlink config files in home and `~/.config`.

### Homebrew

Install [homebrew] first
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

[homebrew]: https://brew.sh/

### Tiling window management

The setup on macOS tries to mirror my i3 setup on Linux. Install [yabai], [skhd], and [sketchybar] :
```sh
brew install koekeishiya/formulae/yabai koekeishiya/formulae/skhd felixkratz/formulae/sketchybar
```

Auto-start:
```sh
brew services start sketchybar
yabai --start-service
skhd --start-service
```

Disable SIP for yabai: https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection.

[yabai]: https://github.com/koekeishiya/yabai
[skhd]: https://github.com/koekeishiya/skhd
[sketchybar]: https://github.com/FelixKratz/SketchyBar

### Terminal and command line utilities

Terminal-related stuff, GNU coreutils and other utilities:
```sh
brew install --cask alacritty
brew install font-fira-mono-nerd-font font-fira-code
brew install powerlevel10k zsh-fast-syntax-highlighting
brew install coreutils findutils bash gawk diffutils grep gzip gnu-sed gnu-tar less wget xz
brew install eza ripgrep fd bat fzf ranger jq btop rename watch ifstat hyperfine
```

Install [macism] to `~/bin` (input method utility used in vim).

[macism]: https://github.com/laishulu/macism

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
