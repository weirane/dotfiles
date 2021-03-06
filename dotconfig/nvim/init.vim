if !has('nvim')
    silent! source $VIMRUNTIME/defaults.vim
    set viminfofile=~/.cache/viminfo
    " cterm cursor shape
    if &term =~# '.\+-256color'
        let &t_SI = "\<Esc>[6 q"
        let &t_EI = "\<Esc>[2 q"
    endif
    finish
endif

let s:dir = expand('<sfile>:p:h')
exec 'source ' . s:dir . '/general.vim'
exec 'source ' . s:dir . '/leader.vim'
exec 'source ' . s:dir . '/plugin.vim'
exec 'source ' . s:dir . '/maps.vim'
exec 'source ' . s:dir . '/fold.vim'

if filereadable(expand('~/.dotfiles/local/vimrc'))
    source ~/.dotfiles/local/vimrc
endif
