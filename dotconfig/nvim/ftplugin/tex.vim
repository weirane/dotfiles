setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal linebreak
setlocal iskeyword-=:

nnoremap <localleader>lw :VimtexCountWords<CR>

let b:airline_whitespace_checks = ['indent', 'trailing']
