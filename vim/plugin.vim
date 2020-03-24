call plug#begin('~/.vim/plugged')
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTree'] }
Plug 'scrooloose/nerdcommenter'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-syntax'
Plug 'kana/vim-textobj-function', { 'for': ['c', 'cpp', 'vim', 'java', 'javascript'] }
Plug 'sgur/vim-textobj-parameter'
Plug 'easymotion/vim-easymotion'
Plug 'lilydjwg/fcitx.vim'
Plug 'itchyny/vim-cursorword'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'mboughaba/i3config.vim'
" Jsonc
Plug 'neoclide/jsonc.vim'
" Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}
" web
Plug 'mattn/emmet-vim', { 'for': ['html', 'markdown'] }
Plug 'pangloss/vim-javascript'
" LaTeX
Plug 'lervag/vimtex'
" Python
Plug 'python-mode/python-mode', { 'branch': 'develop' }
Plug 'Yggdroot/indentLine'
" Go
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Rust
Plug 'rust-lang/rust.vim'
" Toml
Plug 'cespare/vim-toml'
if filereadable(expand('~/.dotfiles/local/vim-plugins.vim'))
    source ~/.dotfiles/local/vim-plugins.vim
endif
call plug#end()

" NERDTree {{{
nnoremap <F10> :silent! NERDTreeToggle<CR>
let NERDTreeShowBookmarks = 1
let NERDTreeShowHidden = 1
" 退出最后一个文件时, 退出 NERDTree
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeIgnore = ['.git']
"}}}

" nerdcommenter {{{
let g:NERDSpaceDelims = 1
let g:NERDAltDelims_c = 1
let g:NERDAltDelims_python = 1
let g:NERDDefaultAlign = 'left'
"}}}

" airline {{{
let g:airline#extensions#coc#enabled = 0
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 2
let g:airline#extensions#whitespace#checks = ['indent', 'trailing', 'mixed-indent-file']
"}}}

" fugitive {{{
nnoremap <silent> <leader>gb :Git blame<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>
nnoremap <silent> <leader>gd :vert Gdiffsplit<CR>
nnoremap <silent> <leader>gs :Git<CR>
nnoremap <silent> <leader>gc :tab Git commit -v<CR>
nnoremap <silent> <leader>gl :Git pull<CR>
nnoremap <silent> <leader>gp :Git push<CR>
"}}}

" gitgutter {{{
highlight GitGutterDelete ctermfg=15
nnoremap <leader>gf :GitGutterFold<CR>
"}}}

" vim-rooter {{{
let g:rooter_use_lcd = 1
let g:rooter_silent_chdir = 1
let g:rooter_patterns = [
            \ 'Cargo.toml', 'package.json', 'Pipfile',
            \ '.git', '.git/', '.hg/',
            \ '.root',
            \]
"}}}

" coc.nvim {{{
" https://github.com/neoclide/coc.nvim#example-vim-configuration
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <C-Space> coc#refresh()
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nmap <localleader>of <Plug>(coc-format)
nmap <localleader>or <Plug>(coc-rename)
nmap <localleader>od <Plug>(coc-definition)
nmap <localleader>oi <Plug>(coc-implementation)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nnoremap <silent> <localleader>ok :call CocAction('doHover')<CR>
"}}}

" easy motion {{{
" ref: http://www.wklken.me/posts/2015/06/07/vim-plugin-easymotion.html
let g:EasyMotion_smartcase = 1
let g:EasyMotion_startofline = 0  " keep cursor colum when JK motion
nnoremap <leader><leader>. <Plug>(easymotion-repeat)
"}}}

" fzf {{{
let $FZF_DEFAULT_COMMAND=expand('$FZF_DEFAULT_COMMAND --no-ignore')
nnoremap <silent><leader>b :Buffers<CR>
nnoremap <silent><leader>ff :Files<CR>
nnoremap <silent><leader>fg :GFiles<CR>
nnoremap <silent><leader>fr :Rg<CR>
"}}}

" easy-align {{{
nmap <leader>a <Plug>(LiveEasyAlign)
vmap <leader>a <Plug>(LiveEasyAlign)
"}}}

" indentLine {{{
let g:indentLine_fileType = ['python', 'yaml']
"}}}

" cursorword {{{
let g:cursorword_delay = 0
"}}}

" html (emmet) {{{
let g:emmet_html5 = 1
let g:user_emmet_settings = {
            \ 'html': {
            \	'empty_element_suffix': ' />'
            \ }
            \}
"}}}

" LaTeX (vimtex) {{{
let g:tex_flavor = 'latex'
let g:vimtex_quickfix_autoclose_after_keystrokes = 2
let g:vimtex_compiler_latexmk_engines = {
            \ '_'                : '-xelatex',
            \ 'pdflatex'         : '-pdf',
            \ 'lualatex'         : '-lualatex',
            \ 'xelatex'          : '-xelatex',
            \ 'context (pdftex)' : '-pdf -pdflatex=texexec',
            \ 'context (luatex)' : '-pdf -pdflatex=context',
            \ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
            \}
" fold {{{
" nnoremap <localleader>rf :VimtexRefreshFolds<CR>
let g:vimtex_fold_enabled = 1
let g:vimtex_fold_types = {
            \ 'comments' : {'enabled' : 1},
            \ 'preamble' : {'enabled' : 1},
            \ 'envs' : {
            \   'whitelist' : [
            \      'lstlisting',
            \      'verbatim',
            \      'comment',
            \      'equation',
            \      'equation*',
            \      'eqarray',
            \      'gather',
            \      'align',
            \      'align*',
            \      'tikzpicture',
            \      'figure',
            \      'table',
            \      'frame',
            \      'thebibliography',
            \      'keywords',
            \      'abstract',
            \      'titlepage',
            \   ],
            \   'blacklist' : [
            \      'flushleft',
            \      'flushright',
            \      'center',
            \   ],
            \ },
            \}
"}}}
let g:vimtex_doc_handlers = ['MyDocHandler']
function! MyDocHandler(context)
    call vimtex#doc#make_selection(a:context)
    if !empty(a:context.selected)
        execute '!texdoc' a:context.selected '2>/dev/null &'
    endif
    return 1
endfunction
"}}}

" Python {{{
let g:pymode = 1
let g:pymode_lint = 0
let g:pymode_options_max_line_length = 100
let g:pymode_python = 'python3'
let g:pymode_run_bind = "<localleader>r"
let g:pymode_breakpoint_bind = "<localleader>b"
let g:pymode_breakpoint_cmd =
            \ "__import__('ipdb').set_trace()  # XXX BREAKPOINT"
"}}}

" vim-markdown {{{
let g:vim_markdown_toc_autofit = 1
"}}}

" markdown-preview {{{
let g:mkdp_auto_close = 0
"}}}

" rust.vim {{{
let g:rust_fold = 1
nnoremap <localleader>rt :RustTest<CR>
"}}}

if filereadable(expand('~/.dotfiles/local/vim-plugins-setting.vim'))
    source ~/.dotfiles/local/vim-plugins-setting.vim
endif
