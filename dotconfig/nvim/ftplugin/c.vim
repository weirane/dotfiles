setlocal foldmethod=syntax
setlocal cindent
packadd termdebug

highlight cFunctions guifg=#FF9D4D ctermfg=214

if (&ft == 'c')
    " C only
    setlocal tabstop=8
    setlocal shiftwidth=8
    setlocal softtabstop=8
elseif (&ft == 'cpp')
    " C++ only
    setlocal matchpairs+=<:>
endif