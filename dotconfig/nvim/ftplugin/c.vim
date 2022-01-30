setlocal foldmethod=syntax
setlocal cindent
packadd termdebug

highlight link cFunctions Function

if (&ft == 'cpp')
    " C++ only
    setlocal matchpairs+=<:>
endif
