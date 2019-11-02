setlocal foldmethod=syntax
packadd termdebug

highlight cFunctions guifg=#FF9D4D ctermfg=214

if (&ft == 'c')
    " Avoid C++
    setlocal tabstop=8
    setlocal shiftwidth=8
    setlocal softtabstop=8
endif
