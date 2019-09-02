call plug#begin('~/.vim/plugged')
Plug 'mhinz/vim-startify'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTree'] }
Plug 'w0rp/ale', { 'for': ['c', 'cpp', 'python'] }
Plug 'Valloric/YouCompleteMe'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Shougo/echodoc.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-syntax'
Plug 'kana/vim-textobj-function', { 'for': ['c', 'cpp', 'vim', 'java', 'javascript'] }
Plug 'sgur/vim-textobj-parameter'
Plug 'easymotion/vim-easymotion'
Plug 'lilydjwg/fcitx.vim'
Plug 'itchyny/vim-cursorword'
Plug 'junegunn/vim-easy-align'
" Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}
" web
Plug 'mattn/emmet-vim', { 'for': ['html'] }
Plug 'pangloss/vim-javascript'
" LaTeX
Plug 'lervag/vimtex'
Plug 'gauteh/vim-evince-synctex'
" Python
Plug 'python-mode/python-mode', { 'branch': 'develop' }
Plug 'Yggdroot/indentLine'
Plug 'tell-k/vim-autopep8', { 'for': ['python'] }
" Go
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Rust
Plug 'rust-lang/rust.vim'
if filereadable(expand('~/.dotfiles/local/vim-plugins.vim'))
    source ~/.dotfiles/local/vim-plugins.vim
endif
call plug#end()

" NERDTree {{{
map <F10> :silent! NERDTreeToggle<CR>
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

" ale {{{
let g:ale_sign_column_always = 1
let g:ale_linters = {
            \ 'c': ['clang', 'gcc'],
            \ 'cpp': ['clang', 'gcc'],
            \}
let g:ale_c_parse_makefile = 1
highlight ALEError ctermbg=0
"}}}

" airline {{{
let g:airline#extensions#tabline#enabled = 1
" show buffer number
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#buffer_nr_format = '[%s] '
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 2
let g:airline#extensions#whitespace#checks = ['indent', 'trailing', 'mixed-indent-file']
"}}}

" fugitive {{{
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gw :Gwrite<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit -v<CR>
nnoremap <leader>gl :Gpull<CR>
nnoremap <leader>gp :Gpush<CR>
"}}}

" gitgutter {{{
highlight GitGutterDelete ctermfg=15
nnoremap <leader>gf :GitGutterFold<CR>
"}}}

" Leaderf {{{
noremap <m-m> :LeaderfMru<CR>
noremap <m-f> :LeaderfFunction!<CR>
noremap <m-t> :LeaderfTag<CR>
let g:Lf_RootMarkers = ['.project', '.root', '.git', '.svn']
" 底部状态栏各项的分界标记
let g:Lf_StlSeparator = { 'left': '', 'right': '' }
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_CacheDirectory = expand('~/.vim/tmp')
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_WindowHeight = 0.30
"}}}

" YouCompleteMe {{{
" ref: https://zhuanlan.zhihu.com/p/33046090
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_confirm_extra_conf = 0
let g:ycm_key_invoke_completion = '<c-z>'
let g:ycm_server_python_interpreter = '/usr/bin/python'
" enable ycm do completion for py3 modules
let g:ycm_python_binary_path = '/usr/bin/python3'
let g:ycm_semantic_triggers =  {
            \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
            \ 'cs,css,lua,javascript,rust': ['re!\w{2}'],
            \ }
let g:ycm_filetype_blacklist = {
            \ 'markdown' : 1,
            \ 'text' : 1,
            \}
highlight YcmErrorSection ctermbg=0
"}}}

" echodoc {{{
let g:echodoc_enable_at_startup = 1
"}}}

" vim-gutentags {{{
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg']
let s:vim_tags_dir = expand('~/.vim/tmp/tags')
let g:gutentags_cache_dir = s:vim_tags_dir
if !isdirectory(s:vim_tags_dir)
    silent! call mkdir(s:vim_tags_dir, 'p')
endif
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
"}}}

" easy motion {{{
" ref: http://www.wklken.me/posts/2015/06/07/vim-plugin-easymotion.html
let g:EasyMotion_smartcase = 1
let g:EasyMotion_startofline = 0  " keep cursor colum when JK motion
nnoremap <leader><leader>. <Plug>(easymotion-repeat)
"}}}

" easy-align {{{
xmap <leader>a <Plug>(EasyAlign)
nmap <leader>a <Plug>(EasyAlign)
"}}}

" html (emmet) {{{
let g:emmet_html5 = 1
let g:user_emmet_settings = {
            \ 'html': {
            \	'empty_element_suffix': ' />'
            \ }
            \}
"}}}

" LaTeX (vimtex and vim-evince-synctex) {{{
let g:tex_flavor = 'latex'
let g:vimtex_quickfix_autoclose_after_keystrokes = 2
" compiler: latexmk {{{
let g:vimtex_compiler_latexmk = {
            \ 'backend' : 'jobs',
            \ 'background' : 1,
            \ 'build_dir' : '',
            \ 'callback' : 1,
            \ 'continuous' : 1,
            \ 'executable' : 'latexmk',
            \ 'options' : [
            \   '-file-line-error',
            \   '-synctex=1',
            \   '-interaction=nonstopmode',
            \ ],
            \}
let g:vimtex_compiler_latexmk_engines = {
            \ '_'                : '-xelatex',
            \ 'pdflatex'         : '-pdf',
            \ 'lualatex'         : '-lualatex',
            \ 'xelatex'          : '-xelatex',
            \ 'context (pdftex)' : '-pdf -pdflatex=texexec',
            \ 'context (luatex)' : '-pdf -pdflatex=context',
            \ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
            \}
"}}}
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
if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif
silent! let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme
" forward search (command provided by vim-evince-synctex)
nnoremap <localleader>lf :VimtexForwardSearch<CR>
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
let g:pymode_options_max_line_length = 120
let g:pymode_python = 'python3'
let g:pymode_quickfix_maxheight = 3
let g:pymode_run_bind = "<localleader>r"
let g:pymode_breakpoint_bind = "<localleader>b"
let g:pymode_trim_whitespaces = 1
let g:pymode_lint_cwindow = 0
let g:pymode_lint_ignore = ["W0401"]
let g:pymode_breakpoint_cmd =
            \ "__import__('ipdb').set_trace()  # XXX BREAKPOINT"

let g:indentLine_fileType = ['python']

let g:autopep8_on_save = 1
let g:autopep8_disable_show_diff = 1
let g:autopep8_max_line_length = 120
"}}}

" markdown-preview {{{
let g:mkdp_auto_close = 0
"}}}

" rust.vim {{{
let g:rust_fold = 1
let g:rustfmt_autosave = 1
"}}}

if filereadable(expand('~/.dotfiles/local/vim-plugins-setting.vim'))
    source ~/.dotfiles/local/vim-plugins-setting.vim
endif
