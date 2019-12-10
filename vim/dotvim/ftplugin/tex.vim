setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal nolinebreak

nnoremap <localleader>lw :VimtexCountWords<CR>

let b:airline_whitespace_checks = ['indent', 'trailing']

" 设置了 wrap 之后直观地上下移动 {{{
noremap 0 g0
noremap ^ g^
noremap $ g$
noremap j gj
noremap k gk

noremap g0 0
noremap g^ ^
noremap g$ $
noremap gj j
noremap gk k
"}}}
