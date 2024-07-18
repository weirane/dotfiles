#!/bin/zsh

alias macism=$HOME/bin/macism

declare -A mapping
mapping=(
    [com.apple.inputmethod.SCIM.Shuangpin]=com.apple.keylayout.US
    [com.apple.keylayout.US]=com.apple.inputmethod.SCIM.Shuangpin
)
current=$(macism)
macism ${mapping[$current]}
