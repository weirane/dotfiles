# wudao-dict completion
# from https://stackoverflow.com/questions/3249432/can-a-bash-tab-completion-script-be-used-in-zsh
autoload bashcompinit
bashcompinit
[[ -f ~/git/wudao-dict/wudao-dict/wd_com ]] \
	&& \. ~/git/wudao-dict/wudao-dict/wd_com
