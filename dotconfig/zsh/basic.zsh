export LANG=en_US.UTF-8
export LC_TIME=en_GB.UTF-8

PROMPT_EOL_MARK="%B%F{8}↵%f%b"
cdpath=(~ ..)
HISTSIZE=99999999
SAVEHIST=99999999
WORDCHARS="-"
ZLE_SPACE_SUFFIX_CHARS='&|'

setopt rc_quotes  # '' as ' in single quotes
setopt extendedglob
setopt auto_cd
setopt prompt_subst
setopt interactive_comments
setopt long_list_jobs

setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_minus

unsetopt menu_complete
unsetopt flow_control
setopt auto_menu
setopt complete_in_word
setopt always_to_end

setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history

title() {
    : ${2=$1}
    case $TERM in
        screen*|tmux*)
            print -Pn "\ek${1:q}\e\\" # set screen hardstatus
            ;;
        *)
            print -Pn "\e]2;${2:q}\a" # set window name
            print -Pn "\e]1;${1:q}\a" # set tab name
            ;;
    esac
}
title_precmd() {
    title "%15<…<%3~%<<" "%n@%m:%~"
}
title_preexec() {
    local cmd_name=${1[(wr)^(*=*|sudo|ssh|mosh|rake|-*)]:gs/%/%%}
    local line=${2:gs/%/%%}
    title $cmd_name $line
}
autoload -U add-zsh-hook
add-zsh-hook precmd title_precmd
add-zsh-hook preexec title_preexec

unalias run-help
autoload -Uz run-help
autoload -Uz zcalc
autoload -U colors && colors
