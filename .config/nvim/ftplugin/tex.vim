" ---LaTeX keybinding
inoremap <buffer> <leader>item \begin{itemize}<Enter><Enter>\end{itemize}<Enter><++><Esc>2ki\item<space>
inoremap <buffer> <leader>enum \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><++><Esc>2ki\item<space>
inoremap <buffer> <leader>desc \begin{description}<Enter><Enter>\end{description}<Esc>2ki\item<space>
inoremap <buffer> <leader>I \item<space>
inoremap <buffer> <leader>eq \begin{equation}<Enter><Enter>\end{equation}<Enter><++><Esc>2ki
inoremap <buffer> <leader>tab \begin{tabular}[t]{}<Enter><++><Enter>\end{tabular}<Enter><++><Esc>3k/]{<Enter>2li
inoremap <buffer> <leader>{ \{\}<++><Esc>5hi
"Bold selected text
vnoremap <buffer> <leader>b <esc>`>a}<esc>`<i\textbf{<esc>
"italicize selected text
vnoremap <buffer> <leader>i <esc>`>a}<esc>`<i\textit{<esc>
"math tag selected text
vnoremap <buffer> <leader>$ <esc>`>a$<esc>`<i$<esc>

