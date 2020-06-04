" syn region texZone start="\\begin{lstlisting}" end="\\end{lstlisting}\|%stopzone\>"
syntax match texInput =\lstinputlisting\s\+[a-zA-Z/.0-9_^]\+=hs=s+17 contains=texStatement
" syn match texInputFile "\\lstinline\s*\(\[.*\]\)\={.\{-}}" contains=texStatement,texInputCurlies,texInputFileOpt
syntax region texZone start="%startzone\>" end="%stopzone\>"
syntax region texZone start="\v\\lstinline(\[.*\])?\z([^\ta-zA-Z])" end="\z1\|%stopzone\>"
syntax region texComment   start="^\\begin{comment}$"    end="^\\end{comment}$"
syntax match texStatement "\\\a*@[a-zA-Z@]*"
syntax match texTypeStyle /\\mathscr\>/
syntax match texTypeStyle /\\normalfont\>/
syntax match texTypeStyle /\\bm\>/
