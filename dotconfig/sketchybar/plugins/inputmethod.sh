#!/bin/zsh

alias macism=$HOME/bin/macism

declare -A mapping
mapping=(
    [com.apple.inputmethod.SCIM.Shuangpin]=com.apple.keylayout.US
    [com.apple.keylayout.US]=com.apple.inputmethod.SCIM.Shuangpin
)
current=$(macism)

if [[ $SENDER == mouse.clicked ]]; then
    current=${mapping[$current]}
    macism $current
fi

FONT_SANS_SERIF="SF Pro:Semibold"
declare -A icon fontsize
icon=(
    [com.apple.inputmethod.SCIM.Shuangpin]=双
    [com.apple.keylayout.US]=A
)
fontsize=(
    [com.apple.inputmethod.SCIM.Shuangpin]=14.0
    [com.apple.keylayout.US]=16.0
)
sketchybar --set inputmethod icon=${icon[$current]} icon.font=$FONT_SANS_SERIF:${fontsize[$current]}
