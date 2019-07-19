setlocal foldmethod=syntax
packadd termdebug

highlight cFunctions guifg=#FF9D4D ctermfg=214

if (&ft == 'cpp')
    let g:ycm_global_ycm_extra_conf = expand('~/.vim/ycm_extra_conf/cpp.py')
else
    setlocal tabstop=8
    setlocal shiftwidth=8
    setlocal softtabstop=8
    let g:ycm_global_ycm_extra_conf = expand('~/.vim/ycm_extra_conf/c.py')
endif

