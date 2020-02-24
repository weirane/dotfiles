set nocompatible
set undofile
set expandtab
set scrolloff=3
set noshowmode
set autoindent
set cindent
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
set formatoptions+=mM
set fencs=utf-8,gbk
if v:lang =~? '^/(zh/)/|/(ja/)/|/(ko/)'
    set ambiwidth=double
endif

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
endif

" Line width limit
function! s:set_color_column(...)
    let width = get(a:, 1, 80)
    let &colorcolumn = width
    let &textwidth = width
    set formatoptions+=ta
endfunction

command! -nargs=? LineLimit :call <SID>set_color_column(<f-args>)
