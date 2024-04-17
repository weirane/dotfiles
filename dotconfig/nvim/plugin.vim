call plug#begin('~/.local/share/nvim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTree'] }
Plug 'scrooloose/nerdcommenter'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'kana/vim-textobj-user'
Plug 'sgur/vim-textobj-parameter'
Plug 'justinmk/vim-sneak'
Plug 'lilydjwg/fcitx.vim'
Plug 'itchyny/vim-cursorword'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'mboughaba/i3config.vim'
Plug 'ap/vim-css-color'
Plug 'Yggdroot/indentLine'
Plug 'machakann/vim-highlightedyank'
" CSV
Plug 'chrisbra/csv.vim'
" Jsonc
Plug 'neoclide/jsonc.vim'
" Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
" web
Plug 'pangloss/vim-javascript'
" LaTeX
Plug 'lervag/vimtex'
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
let NERDTreeBookmarksFile = expand('~/.cache/nerdtree-bookmarks')
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
let g:NERDCustomDelimiters = {
            \ 'nroff': { 'left': '.\"' },
            \ }
"}}}

" lightline.vim {{{
autocmd User VimtexEventCompileSuccess,VimtexEventCompileFailed call lightline#update()

function! LightlineFileEncmat() abort
    return &filetype !~# '\v^(help|man)$' && winwidth(0) > 70
                \ ? &fileencoding . (&fileformat !=# '' ? printf('[%s]', &fileformat) : '')
                \ : ''
endfunction

function! LightlineFiletype() abort
    return &filetype
endfunction

function! LightlineGit() abort
    if &filetype =~# '\v^(help|man)$' || winwidth(0) <= 60 | return '' | endif
    let l:branch = FugitiveHead(6)
    if empty(l:branch) || winwidth(0) <= 70 | return l:branch | endif
    let l:sum = exists('b:gitgutter.summary') ? b:gitgutter.summary : [0, 0, 0]
    let l:summary = max(l:sum) > 0 ? printf(' +%d ~%d -%d', l:sum[0], l:sum[1], l:sum[2]) : ''
    return l:branch . l:summary
endfunction

function! LightlinePlugStatus() abort
    if &filetype ==# 'csv' && exists('*CSV_WCol')
        return printf('[%s%s]', CSV_WCol('Name'), CSV_WCol())
    elseif exists('b:vimtex')
        let l:status = ''
        let vt_local = get(b:, 'vimtex_local', {})
        if !empty(vt_local)
            let l:status .= get(vt_local, 'active') ? 'l' : 'm'
        endif

        if get(get(b:vimtex, 'viewer', {}), 'xwin_id')
            let l:status .= 'v'
        endif

        let l:compiler = get(b:vimtex, 'compiler', {})
        if has_key(l:compiler, 'is_running') && l:compiler.is_running()
            let l:status .= get(l:compiler, 'continuous') ? 'c' : 'c₁'
        endif
        return empty(l:status) ? '' : printf('Vimtex: {%s}', l:status)
    elseif get(g:, 'coc_enabled', 0)
        return coc#status()
    else
        return ''
    end
endfunction

function! LightlineReadonly() abort
    return &filetype !~# '\v^(help|man)$' && &readonly ? 'RO' : ''
endfunction

let g:lightline_wordcount_ft = ['asciidoc', 'help', 'mail', 'markdown', 'nroff', 'org', 'rst', 'plaintex', 'tex', 'text']
function! LightlineWordcount() abort
    return index(g:lightline_wordcount_ft, &filetype) >= 0 || empty(@%)
                \ ? get(wordcount(), mode() =~# '[vVsS\x16\x13]' ? 'visual_words' : 'words', 0) . ' W'
                \ : ''
endfunction

let g:lightline = {
      \ 'active': {
      \   'left': [['mode', 'paste', 'spell'],
      \            ['gitstatus', 'filename', 'readonly'],
      \            ['plugstatus']],
      \   'right': [['wordcount', 'percent', 'lineinfo'],
      \             ['fileencmat'],
      \             ['filetype']],
      \ },
      \ 'component': {
      \   'filename': "%<%{expand('%:t') !=# '' ? substitute(@%, $HOME, '~', '') . (&modified ? '[+]' : '') : '[No Name]'}",
      \   'lineinfo': '%l:%-2v',
      \   'percent': '%2p%%',
      \ },
      \ 'component_function': {
      \   'fileencmat': 'LightlineFileEncmat',
      \   'filetype': 'LightlineFiletype',
      \   'gitstatus': 'LightlineGit',
      \   'plugstatus': 'LightlinePlugStatus',
      \   'readonly': 'LightlineReadonly',
      \   'wordcount': 'LightlineWordcount',
      \ },
      \ 'component_function_visible_condition': {
      \   'wordcount': 'index(g:lightline_wordcount_ft, &filetype) >= 0 || empty(@%)',
      \ },
      \ 'subseparator': {
      \   'left': '│', 'right': '│',
      \ },
      \ }
"}}}

" fugitive {{{
nnoremap <silent> <leader>gg :tab Git<CR>
nnoremap <silent> <leader>gb :Git blame<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>
nnoremap <silent> <leader>gd :vert Gdiffsplit<CR>
nnoremap <silent> <leader>gc :tab Git commit -v<CR>
"}}}

" gitgutter {{{
nnoremap <silent> <leader>gp :GitGutterPreviewHunk<CR>
nnoremap <silent> <leader>ga :GitGutterStageHunk<CR>
nnoremap <silent> <leader>gu :GitGutterUndoHunk<CR>
nnoremap <leader>gf :GitGutterFold<CR>
"}}}

" vim-rooter {{{
let g:rooter_cd_cmd = "lcd"
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
            \ coc#pum#visible() ? coc#pum#next(1) :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <silent><expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <C-z> coc#refresh()
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || col + 1 == col('$') || getline('.')[col - 1]  =~# '\s'
endfunction

highlight! link CocMenuSel PmenuSel
highlight! link CocInlayHint CocCodeLens

nmap <silent> <localleader>oa <Plug>(coc-codeaction-line)
nmap <localleader>ca <Plug>(coc-codelens-action)
xmap <localleader>oa <Plug>(coc-codeaction-selected)
nmap <localleader>of <Plug>(coc-format)
xmap <localleader>of <Plug>(coc-format-selected)
nmap <localleader>or <Plug>(coc-rename)
nmap <localleader>od <Plug>(coc-definition)
nmap <localleader>on <Plug>(coc-references)
nmap <localleader>oi <Plug>(coc-implementation)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nnoremap <silent> <localleader>ok :call CocAction('doHover')<CR>
"}}}

" fzf {{{
let $FZF_DEFAULT_COMMAND=expand('$FZF_DEFAULT_COMMAND --no-ignore')
let g:fzf_layout = { 'down': '40%' }
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
let g:indentLine_fileType = ['python', 'yaml', 'ruby', 'haskell']
"}}}

" cursorword {{{
let g:cursorword_delay = 0
"}}}

" highlightedyank {{{
let g:highlightedyank_highlight_duration = 300
"}}}

" LaTeX (vimtex) {{{
let g:tex_flavor = 'latex'
let g:vimtex_quickfix_autoclose_after_keystrokes = 2
let g:vimtex_compiler_latexmk = { 'build_dir': 'build' }
let g:vimtex_compiler_latexmk_engines = {
            \ '_'                : '-xelatex',
            \ 'pdflatex'         : '-pdf',
            \ 'lualatex'         : '-lualatex',
            \ 'xelatex'          : '-xelatex',
            \ 'context (pdftex)' : '-pdf -pdflatex=texexec',
            \ 'context (luatex)' : '-pdf -pdflatex=context',
            \ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
            \}
let g:vimtex_view_method = 'zathura'
let g:vimtex_view_use_temp_files = 1
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

" vim-markdown {{{
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_toc_autofit = 1
map <Plug> <Plug>Markdown_MoveToCurHeader
"}}}

" markdown-preview {{{
let g:mkdp_auto_close = 0
let g:mkdp_page_title = '${name}'
"}}}

" rust.vim {{{
let g:rust_fold = 1
nnoremap <localleader>rt :RustTest<CR>
"}}}
