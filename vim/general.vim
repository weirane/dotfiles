set nocompatible
set undofile
set expandtab
set scrolloff=3
set noshowmode
set autoindent
set nocindent
set cinoptions+=:0
set cinoptions+=g0
set cinoptions+=N-s
set mouse=a
set number
set tabstop=4
set shiftwidth=4
set showcmd
set hidden
set linebreak
set nohlsearch
set backspace=indent,eol,start
set exrc
set secure
set ignorecase
set wildignorecase
set smartcase
set completeopt=menu,menuone
set pumheight=10
set updatetime=100
set incsearch
set wildmenu
set shortmess+=c
set nojoinspaces
set formatoptions+=lnt
set nostartofline

syntax on
filetype plugin on
filetype indent on
colorscheme slate
highlight PMenu ctermfg=0 ctermbg=242
highlight ColorColumn ctermbg=8

let s:vim_tmp_dir = expand('~/.vim/tmp')
if !isdirectory(s:vim_tmp_dir)
    silent! call mkdir(s:vim_tmp_dir, 'p')
endif
set backupdir=~/.vim/tmp
set undodir=~/.vim/tmp
set noswapfile

packadd! matchit

" cterm cursor shape
if &term =~# '.\+-256color'
    let &t_SI = "\<Esc>[6 q"
    let &t_EI = "\<Esc>[2 q"
endif

" encodings, multibyte
set encoding=utf-8
set termencoding=utf-8
set formatoptions+=mB
set fencs=utf-8,gbk

" for gvim
if has("gui_running")
    set guifont=Consolas\ 13
    set winaltkeys=no
    colorscheme evening
    highlight PMenu ctermfg=0 ctermbg=242 guifg=#000000 guibg=#6c6c6c
    set guioptions-=T  " remove tool bar
    set guioptions-=r  " remove right scroll bar
    set guioptions-=L  " remove left one
endif

" From defaults.vim
let c_comment_strings=1
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                \ | wincmd p | diffthis
endif
augroup vimStartup
    " When editing a file, always jump to the last known cursor position.
    au!
    autocmd BufReadPost *
                \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
                \ | exe "normal! g`\"" | endif
augroup END

" neovim/vim specific settings
if has('nvim')
    set inccommand=nosplit
else
    set ttymouse=sgr
    set timeoutlen=100
endif

" Line width limit
function! s:set_color_column(...)
    let l:width = get(a:, 1, 80)
    if (l:width == "-s")
        let l:width = get(a:, 2, 80)
        if (l:width <= 0)
            return
        endif
        setlocal formatoptions-=a
    else
        if (l:width <= 0)
            return
        endif
        setlocal formatoptions+=a
    endif
    let &l:colorcolumn = l:width + 1
    let &l:textwidth = l:width
endfunction

command! -nargs=* LineLimit :call <SID>set_color_column(<f-args>)

" move by line
function! s:move_by_line() abort
    nnoremap <buffer> 0 g0
    nnoremap <buffer> ^ g^
    nnoremap <buffer> $ g$
    nnoremap <buffer> j gj
    nnoremap <buffer> k gk

    nnoremap <buffer> g0 0
    nnoremap <buffer> g^ ^
    nnoremap <buffer> g$ $
    nnoremap <buffer> gj j
    nnoremap <buffer> gk k

    vnoremap <buffer> 0 g0
    vnoremap <buffer> ^ g^
    vnoremap <buffer> $ g$
    vnoremap <buffer> j gj
    vnoremap <buffer> k gk

    vnoremap <buffer> g0 0
    vnoremap <buffer> g^ ^
    vnoremap <buffer> g$ $
    vnoremap <buffer> gj j
    vnoremap <buffer> gk k
endfunction

command! -nargs=0 MoveByLine :call <SID>move_by_line()

augroup MoveByLine
    au!
    autocmd Filetype text,markdown,tex exec 'MoveByLine'
augroup END
