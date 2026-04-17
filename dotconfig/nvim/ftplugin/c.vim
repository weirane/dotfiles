setlocal foldmethod=syntax
setlocal cindent

highlight link cFunctions Function

if (&ft == 'cpp')
    " C++ only
    setlocal matchpairs+=<:>
endif
