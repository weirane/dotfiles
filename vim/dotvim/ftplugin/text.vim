setlocal nolinebreak
setlocal nocindent
silent! call airline#extensions#whitespace#disable()

" 设置了  wrap 之后直观地上下移动 {{{
nnoremap 0 g0
vnoremap 0 g0
nnoremap ^ g^
vnoremap ^ g^
nnoremap $ g$
vnoremap $ g$
nnoremap j gj
vnoremap j gj
nnoremap k gk
vnoremap k gk

nnoremap g0 0
vnoremap g0 0
nnoremap g^ ^
vnoremap g^ ^
nnoremap g$ $
vnoremap g$ $
nnoremap gj j
vnoremap gj j
nnoremap gk k
vnoremap gk k
"}}}
