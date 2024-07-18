scriptencoding utf-8

" Adapted from https://github.com/lilydjwg/fcitx.vim
" Need to install macism from https://github.com/laishulu/macism

if &cp || exists("g:loaded_macism")
  finish
endif
let s:keepcpo = &cpo
set cpo&vim

function s:setup_cmd()
  function Macism2en()
    let inputstatus = trim(system(g:macism_path))
    if inputstatus =~ '.inputmethod.'
      let b:inputsaved = inputstatus
      call system(g:macism_path . ' com.apple.keylayout.US')
    endif
  endfunction

  function Macism2zh()
    try
      if b:inputsaved != ""
        call system(g:macism_path . ' ' . b:inputsaved)
        let b:inputsaved = ""
      endif
    catch /inputsaved/
      let b:inputsaved = ""
    endtry
  endfunction

  let g:loaded_macism = 1
endfunction

if exists("g:macism_path")
  call s:setup_cmd()
else
  if executable('macism')
    let g:macism_path = 'macism'
    call s:setup_cmd()
  endif
endif

" Register autocmd if successfully loaded.
if exists("g:loaded_macism")
  au InsertLeavePre * if reg_executing() == "" | call Macism2en() | endif
  au InsertEnter * if reg_executing() == "" | call Macism2zh() | endif
  au CmdlineEnter [/\?] if reg_executing() == "" | call Macism2zh() | endif
  au CmdlineLeave [/\?] if reg_executing() == "" | call Macism2en() | endif
endif

" ---------------------------------------------------------------------
"  Restoration And Modelines:
let &cpo=s:keepcpo
unlet s:keepcpo
