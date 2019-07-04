source $VIMRUNTIME/defaults.vim

set nocompatible
set undofile
set expandtab
set scrolloff=3
set noshowmode
set autoindent
set cindent
set cinoptions+=:0
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

syntax on
filetype plugin on
filetype indent on
colorscheme slate

let s:vim_tmp_dir = expand('~/.vim/tmp')
if !isdirectory(s:vim_tmp_dir)
	silent! call mkdir(s:vim_tmp_dir, 'p')
endif
set backupdir=~/.vim/tmp
set undodir=~/.vim/tmp
set noswapfile

packadd! matchit

" cterm cursor shape
if &term == 'xterm-256color' || &term == 'screen-256color'
	let &t_SI = "\<Esc>[5 q"
	let &t_EI = "\<Esc>[1 q"
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
	set guioptions-=T  " remove tool bar
	set guioptions-=r  " remove right scroll bar
	set guioptions-=L  " remove left one
endif

" alt key problem
function! Terminal_MetaMode(mode)
	set ttimeout
	if $TMUX != ''
		set ttimeoutlen=30
	elseif &ttimeoutlen > 80 || &ttimeoutlen <= 0
		set ttimeoutlen=80
	endif
	if has('nvim') || has('gui_running')
		return
	endif
	function! s:metacode(mode, key)
		if a:mode == 0
			exec "set <M-".a:key.">=\e".a:key
		else
			exec "set <M-".a:key.">=\e]{0}".a:key."~"
		endif
	endfunc
	for i in range(10)
		call s:metacode(a:mode, nr2char(char2nr('0') + i))
	endfor
	for i in range(26)
		call s:metacode(a:mode, nr2char(char2nr('a') + i))
		call s:metacode(a:mode, nr2char(char2nr('A') + i))
	endfor
	if a:mode != 0
		for c in [',', '.', '/', ';', '[', ']', '{', '}']
			call s:metacode(a:mode, c)
		endfor
		for c in ['?', ':', '-', '_']
			call s:metacode(a:mode, c)
		endfor
	else
		for c in [',', '.', '/', ';', '{', '}']
			call s:metacode(a:mode, c)
		endfor
		for c in ['?', ':', '-', '_']
			call s:metacode(a:mode, c)
		endfor
	endif
endfunc
call Terminal_MetaMode(0)
