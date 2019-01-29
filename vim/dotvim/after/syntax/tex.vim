" syn region texZone start="\\begin{lstlisting}" end="\\end{lstlisting}\|%stopzone\>"
syn region texZone  start="\\lstinputlisting" end="{\s*[a-zA-Z/.0-9_^]\+\s*}"
" syn match texInputFile "\\lstinline\s*\(\[.*\]\)\={.\{-}}" contains=texStatement,texInputCurlies,texInputFileOpt
syn region texZone start="%startzone\>" end="%stopzone\>"
syn region texZone start="\v\\lstinline(\[.*\])?\z([^\ta-zA-Z])" end="\z1\|%stopzone\>"
syn region texComment   start="^\\begin{comment}$"    end="^\\end{comment}$"
syn match texStatement "\\\a*@[a-zA-Z@]*"
syn match texTypeStyle /\\mathscr\>/
syn match texTypeStyle /\\normalfont\>/
syn match texTypeStyle /\\bm\>/
