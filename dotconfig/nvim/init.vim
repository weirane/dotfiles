let s:dir = expand('<sfile>:p:h')
exec 'source ' . s:dir . '/general.vim'
exec 'source ' . s:dir . '/leader.vim'
exec 'source ' . s:dir . '/plugin.vim'
exec 'source ' . s:dir . '/maps.vim'
exec 'source ' . s:dir . '/fold.vim'

if filereadable(expand('~/.dotfiles/local/vimrc'))
    source ~/.dotfiles/local/vimrc
endif
