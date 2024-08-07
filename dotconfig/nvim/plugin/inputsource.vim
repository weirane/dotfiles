" Adapted from https://github.com/lilydjwg/fcitx.vim
" vim:ts=2:sw=2:sts=2

if exists("g:loaded_inputsource")
  finish
endif

function s:setup_cmd()
  function Inputsource2en()
    let inputstatus = trim(system(s:inputsource_path))
    if inputstatus == 'Non-US'
      let b:inputsaved = inputstatus
      call system(s:inputsource_path . ' switch')
    endif
  endfunction

  function Inputsource2zh()
    try
      if b:inputsaved != ""
        call system(s:inputsource_path . ' switch')
        let b:inputsaved = ""
      endif
    catch /inputsaved/
      let b:inputsaved = ""
    endtry
  endfunction

  let g:loaded_inputsource = 1
endfunction

if executable('inputsource')
  let s:inputsource_path = 'inputsource'
  call s:setup_cmd()
endif

" Register autocmd if successfully loaded.
if exists("g:loaded_inputsource")
  au InsertLeavePre * if reg_executing() == "" | call Inputsource2en() | endif
  au InsertEnter * if reg_executing() == "" | call Inputsource2zh() | endif
  au CmdlineEnter [/\?] if reg_executing() == "" | call Inputsource2zh() | endif
  au CmdlineLeave [/\?] if reg_executing() == "" | call Inputsource2en() | endif
endif
