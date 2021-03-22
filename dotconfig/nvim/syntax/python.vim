" Taken from https://github.com/vim-python/python-syntax/blob/2cc00ba729/syntax/python.vim

syn region pythonFString   start=+[fF]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonEscape,@Spell
syn region pythonFString   start=+[fF]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonEscape,@Spell
syn region pythonFString   start=+[fF]'''+ skip=+\\'+ end=+'''+ keepend contains=pythonEscape,pythonDocTest,pythonSpaceError,@Spell
syn region pythonFString   start=+[fF]"""+ skip=+\\"+ end=+"""+ keepend contains=pythonEscape,pythonDocTest,pythonSpaceError,@Spell

syn region pythonRawFString   start=+\%([fF][rR]\|[rR][fF]\)'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonEscape,@Spell
syn region pythonRawFString   start=+\%([fF][rR]\|[rR][fF]\)"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonEscape,@Spell
syn region pythonRawFString   start=+\%([fF][rR]\|[rR][fF]\)'''+ skip=+\\'+ end=+'''+ keepend contains=pythonEscape,pythonDocTest,pythonSpaceError,@Spell
syn region pythonRawFString   start=+\%([fF][rR]\|[rR][fF]\)"""+ skip=+\\"+ end=+"""+ keepend contains=pythonEscape,pythonDocTest,pythonSpaceError,@Spell

syn region pythonBytes    start=+[bB]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonBytesError,pythonBytesContent,@Spell
syn region pythonBytes    start=+[bB]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonBytesError,pythonBytesContent,@Spell
syn region pythonBytes    start=+[bB]'''+ skip=+\\'+ end=+'''+ keepend contains=pythonBytesError,pythonBytesContent,pythonDocTest,pythonSpaceError,@Spell
syn region pythonBytes    start=+[bB]"""+ skip=+\\"+ end=+"""+ keepend contains=pythonBytesError,pythonBytesContent,pythonDocTest,pythonSpaceError,@Spell

syn match pythonBytesError    '.\+' display contained
syn match pythonBytesContent  '[\u0000-\u00ff]\+' display contained contains=pythonEscape,pythonBytesEscapeError
syn match pythonBytesEscapeError  '\\\o\{,2}[89]' display contained
syn match pythonBytesEscapeError  '\\x\x\=\X' display contained

syn region pythonRawBytes  start=+\%([bB][rR]\|[rR][bB]\)'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=@Spell
syn region pythonRawBytes  start=+\%([bB][rR]\|[rR][bB]\)"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=@Spell
syn region pythonRawBytes  start=+\%([bB][rR]\|[rR][bB]\)'''+ skip=+\\'+ end=+'''+ keepend contains=pythonDocTest,pythonSpaceError,@Spell
syn region pythonRawBytes  start=+\%([bB][rR]\|[rR][bB]\)"""+ skip=+\\"+ end=+"""+ keepend contains=pythonDocTest,pythonSpaceError,@Spell

syn match pythonStrFormatting '%\%(([^)]\+)\)\=[-#0 +]*\d*\%(\.\d\+\)\=[hlL]\=[diouxXeEfFgGcrs%]' contained containedin=pythonString,pythonRawString
syn match pythonStrFormatting '%[-#0 +]*\%(\*\|\d\+\)\=\%(\.\%(\*\|\d\+\)\)\=[hlL]\=[diouxXeEfFgGcrs%]' contained containedin=pythonString,pythonRawString

syn cluster pythonExpression contains=pythonStatement,pythonRepeat,pythonConditional,pythonOperator,pythonNumber,pythonString,pythonFString,pythonRawString,pythonRawFString,pythonBytes,pythonRawBytes,pythonBuiltin

syn match pythonStrFormat "{\%(\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*\|\d\+\)\=\%(\.\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*\|\[\%(\d\+\|[^!:\}]\+\)\]\)*\%(![rsa]\)\=\%(:\%({\%(\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*\|\d\+\)}\|\%([^}]\=[<>=^]\)\=[ +-]\=#\=0\=\d*,\=\%(\.\d\+\)\=[bcdeEfFgGnosxX%]\=\)\=\)\=}" contained containedin=pythonString,pythonRawString
syn region pythonStrInterpRegion matchgroup=pythonStrFormat start="{" end="\%(![rsa]\)\=\%(:\%({\%(\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*\|\d\+\)}\|\%([^}]\=[<>=^]\)\=[ +-]\=#\=0\=\d*,\=\%(\.\d\+\)\=[bcdeEfFgGnosxX%]\=\)\=\)\=}" extend contained containedin=pythonFString,pythonRawFString contains=pythonStrInterpRegion,@pythonExpression
syn match pythonStrFormat "{{\|}}" contained containedin=pythonFString,pythonRawFString

hi def link pythonFString String
hi def link pythonRawFString String
hi def link pythonBytes String
hi def link pythonRawBytes String
hi def link pythonBytesContent String
hi def link pythonBytesError Error
hi def link pythonStrFormat Special
hi def link pythonStrFormatting Special
