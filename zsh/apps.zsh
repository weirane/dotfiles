# helper scripts and binaries
prependpath ~/bin
prependpath ~/scripts

# cargo
prependpath ~/.cargo/bin

# neovim
if command -v nvim >/dev/null; then
    export EDITOR=nvim
    alias vi='command vim'
    alias vim='nvim'
else
    export EDITOR=vim
fi

# exa
if command -v exa >/dev/null; then
    alias ls='exa'
    alias ll='exa -lgh'
    alias la='exa -lagh'

    export EXA_COLORS='uu=38;5;249:un=38;5;241:gu=38;5;245:gn=38;5;241:da=38;5;245:sn=38;5;7:sb=38;5;7:ur=38;5;3;1:uw=38;5;5;1:ux=38;5;1;1:ue=38;5;1;1:gr=38;5;249:gw=38;5;249:gx=38;5;249:tr=38;5;249:tw=38;5;249:tx=38;5;249:xa=38;5;12:rs=0:di=1;34:ln=1;36:mh=00:pi=40;33:so=1;35:do=1;35:bd=40;33;1:cd=40;33;1:or=1;05;37;41:mi=1;05;37;41:su=37;41:sg=30;43:ca=30;41:ow=34;42:st=37;44:ex=1;32:*.tar=1;31:*.tgz=1;31:*.arc=1;31:*.arj=1;31:*.taz=1;31:*.lha=1;31:*.lz4=1;31:*.lzh=1;31:*.lzma=1;31:*.tlz=1;31:*.txz=1;31:*.tzo=1;31:*.t7z=1;31:*.zip=1;31:*.z=1;31:*.Z=1;31:*.dz=1;31:*.gz=1;31:*.lrz=1;31:*.lz=1;31:*.lzo=1;31:*.xz=1;31:*.bz2=1;31:*.bz=1;31:*.tbz=1;31:*.tbz2=1;31:*.tz=1;31:*.deb=1;31:*.rpm=1;31:*.jar=1;31:*.war=1;31:*.ear=1;31:*.sar=1;31:*.rar=1;31:*.alz=1;31:*.ace=1;31:*.zoo=1;31:*.cpio=1;31:*.7z=1;31:*.rz=1;31:*.cab=1;31:*.jpg=1;35:*.jpeg=1;35:*.gif=1;35:*.bmp=1;35:*.pbm=1;35:*.pgm=1;35:*.ppm=1;35:*.tga=1;35:*.xbm=1;35:*.xpm=1;35:*.tif=1;35:*.tiff=1;35:*.png=1;35:*.svg=1;35:*.svgz=1;35:*.mng=1;35:*.pcx=1;35:*.mov=1;35:*.mpg=1;35:*.mpeg=1;35:*.m2v=1;35:*.mkv=1;35:*.webm=1;35:*.ogm=1;35:*.mp4=1;35:*.m4v=1;35:*.mp4v=1;35:*.vob=1;35:*.qt=1;35:*.nuv=1;35:*.wmv=1;35:*.asf=1;35:*.rm=1;35:*.rmvb=1;35:*.flc=1;35:*.avi=1;35:*.fli=1;35:*.flv=1;35:*.gl=1;35:*.dl=1;35:*.xcf=1;35:*.xwd=1;35:*.yuv=1;35:*.cgm=1;35:*.emf=1;35:*.axv=1;35:*.anx=1;35:*.ogv=1;35:*.ogx=1;35:*.pdf=00;32:*.ps=00;32:*.txt=00;32:*.patch=00;32:*.diff=00;32:*.log=00;32:*.tex=00;32:*.doc=00;32:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36'
fi

# fzf
fzf1=/usr/share/fzf

if [ -f $fzf1/key-bindings.zsh ] && [ -f $fzf1/completion.zsh ]; then
    . $fzf1/key-bindings.zsh
    . $fzf1/completion.zsh
elif [ -f ~/.fzf.zsh ]; then
    . ~/.fzf.zsh
fi
unset fzf1

if command -v fd >/dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type file --hidden --exclude .git/ --color=always'
    export FZF_DEFAULT_OPTS='--ansi'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# ripgrep
if command -v rg >/dev/null; then
    export RIPGREP_CONFIG_PATH=$HOME/.config/ripgreprc
fi
