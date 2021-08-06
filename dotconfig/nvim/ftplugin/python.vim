setlocal foldmethod=indent
setlocal formatoptions+=ro

" Add breakpoint
nnoremap <silent><buffer> <localleader>b :call <SID>pybreak_operate()<CR>
let g:pybreak_code = "__import__('ipdb').set_trace()  # XXX BREAKPOINT"
function! s:pybreak_operate()
    let l:lnum = line('.')
    if strridx(getline(l:lnum), g:pybreak_code) != -1
        call deletebufline('%', l:lnum)
    elseif l:lnum > 1 && strridx(getline(l:lnum - 1), g:pybreak_code) != -1
        call deletebufline('%', l:lnum - 1)
    else
        let l:plnum = prevnonblank(l:lnum)
        let l:indents = &expandtab ? repeat(' ', indent(l:plnum)) : repeat("\t", l:plnum / &shiftwidth)
        call append(l:lnum - 1, l:indents . g:pybreak_code)
    endif
    noautocmd write
endfunction
