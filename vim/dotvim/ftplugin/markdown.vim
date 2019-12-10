setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal expandtab
setlocal nolinebreak
silent! call airline#extensions#whitespace#disable()

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
