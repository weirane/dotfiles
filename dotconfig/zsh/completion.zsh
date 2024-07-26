fpath=(
    /opt/homebrew/opt/rustup/share/zsh/site-functions
    /opt/homebrew/share/zsh/site-functions
    $fpath)
zmodload zsh/complist
autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path ${XDG_CACHE_HOME:-$HOME/.cache}/zsh
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"

zstyle ':completion:*:warnings' format $'\e[31m -- No Matches Found --\e[0m'
zstyle ':completion:*:descriptions' format $'\e[2m -- %d --\e[0m'
zstyle ':completion:*:corrections' format $'\e[33m -- %d (errors: %e) --\e[0m'
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.*' insert-sections true
zstyle ':completion:*' group-name ''

zstyle ':completion:*:*:git:*' user-commands ${${(M)${(k)commands}:#git-*}/git-/}

zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]-_}={[:upper:][:lower:]_-}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:(vim|nvim|cat|bat|less):*' file-patterns '^*(vimtex.pdf|.synctex.gz|.o):source-files' '*:all-files'
zstyle -e ':completion::complete:-command-::executables' ignored-patterns '
    local _r=(${(Q)PREFIX/#\~\//$HOME/}*(^x)${(Q)SUFFIX})
    reply=(\*${(q)^_r:t})'

compdef _pids cmdof
compdef _pids envof
compdef {notified,proxied}=command
