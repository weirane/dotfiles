setlocal tabstop=8
setlocal shiftwidth=8
setlocal softtabstop=8
setlocal foldmethod=syntax
packadd! termdebug

hi cFunctions guifg=#FF9D4D ctermfg=214

if (&ft == 'cpp')
	let g:ycm_global_ycm_extra_conf = '/home/wang/.vim/ycm_extra_conf/cpp.py'
else
	let g:ycm_global_ycm_extra_conf = '/home/wang/.vim/ycm_extra_conf/c.py'
endif

