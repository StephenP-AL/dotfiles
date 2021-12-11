"execute pathogen#infect()
syntax on
set nocompatible
filetype plugin indent on
set number
set splitright
set splitbelow
	

" Global keybindings

"noremap <F2> :set spell spelllang=en_us<CR>
"inoremap <F2> <C-O>:set spell spelllang=en_us<CR>
map <F2> :setlocal spell! spelllang=en_us<CR>
inoremap <F2> <Esc>:setlocal spell! spelllang=en_us<CR>a
 
noremap <F3> :set invnumber<CR>
inoremap <F3> <C-O>:set invnumber<CR>

"Save with sudo"
cmap w!! w !sudo tee > /dev/null %

"nmap <silent> <F2> :NERDTreeToggle<CR>

" Panes 
nnoremap <c-w>" :sp `dirname %`<cr> 
inoremap <c-w>" <esc>:sp `dirname %`<cr> 
nnoremap <c-w>% :vsplit `dirname %`<cr> 
inoremap <c-w>% :vsplit `dirname %`<cr> 
""nnoremap <Up>    :resize +2<CR>
""nnoremap <Down>  :resize -2<CR>
""nnoremap <Left>  :vertical resize -2<CR>
""nnoremap <Right> :vertical resize +2<CR>

	" Tabs
nmap <silent> <F4> :tabnew `dirname %`<CR>
nnoremap <F5> :tabp<CR>
nnoremap <F8> :tabn<CR>
nnoremap <silent> <F6> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <F7> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>

"inoremap ;;<space> <Esc>/<++><Enter>4xa
inoremap ;;<space> <Esc>/<++><Enter>"_4cl

" Auto close parethasis
inoremap (	()<Left>
inoremap ((	(
inoremap ()	()
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap ;;)	<Esc>/)<Enter>a

inoremap "	""<Left>
inoremap ;;"	<Esc>/"<Enter>a
inoremap '	''<Left>

inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}
inoremap ;;}	<Esc>/}<Enter>a

" C/C++ keybindings
autocmd BufRead,BufNewFile *.c setlocal filetype=cpp
autocmd FileType cpp inoremap ;;f for(<space>)<Enter>{<Enter><space><++><Enter>}<Enter><++><Esc>4k$T(i
autocmd FileType cpp inoremap ;;w while(<space>)<Enter>{<Enter><space><++><Enter>}<Enter><++><Esc>4k$T(i
autocmd FileType cpp inoremap ;;do do<Enter>{<Enter><space><Enter>}while(<++>);<Enter><++><Esc>2k$i
autocmd FileType cpp inoremap ;;if if(<space>)<Enter>{<Enter><space><++><Enter>}<Enter><++><Esc>4k$T(i
autocmd FileType cpp inoremap ;;el else<Enter>{<Enter><space><Enter>}<Enter><++><Esc>2k$i
autocmd FileType cpp inoremap ;;ei else<space>if(<space>)<Enter>{<Enter><space><++><Enter>}<Enter><++><Esc>4k$T(i
autocmd FileType cpp inoremap ;;de #ifdef<space>DEBUG<Enter><Enter>#endif<Enter><++><Esc>2k$i
autocmd FileType cpp inoremap ;;dm #ifdef<space>DEBUG<Enter>printf("%s\n","---DEBUG---");<Enter>#endif<Enter><++><Esc>3k/%s<Enter>lli
autocmd FileType cpp inoremap ;;d1 #ifdef<space>DEBUG1<Enter>printf("%s\n","---DEBUG1---");<Enter>#endif<Enter><++><Esc>3k/%s<Enter>lli
autocmd FileType cpp inoremap ;;d2 #ifdef<space>DEBUG2<Enter>printf("%s\n","---DEBUG2---");<Enter>#endif<Enter><++><Esc>3k/%s<Enter>lli
autocmd FileType cpp inoremap ;;- //-------------------------------------------<Enter><Enter>-------------------------------------------<Enter><Esc>02xi<++><Esc>2kA<space>

" LaTeX keybinding
autocmd FileType tex inoremap ;;tempa \documentclass{article}<Enter>\title{<++>}<Enter>\author{Stephen Pate}<Enter>\usepackage[margin=1in]{geometry}<Enter><Enter>\begin{document}<Enter>\maketitle<Enter><++><Enter>\end{document}<Esc>8k15li
autocmd BufRead,BufNewFile *.tex setlocal filetype=tex
autocmd FileType tex inoremap ;;item \begin{itemize}<Enter><Enter>\end{itemize}<Enter><++><Esc>2ki\item<space>
autocmd FileType tex inoremap ;;enum \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><++><Esc>2ki\item<space>
autocmd FileType tex inoremap ;;desc \begin{description}<Enter><Enter>\end{description}<Esc>2ki\item<space>
autocmd FileType tex inoremap ;;I \item<space>
autocmd FileType tex inoremap ;;eq \begin{equation}<Enter><Enter>\end{equation}<Enter><++><Esc>2ki
autocmd FileType tex inoremap ;;tab \begin{tabular}[t]{}<Enter><++><Enter>\end{tabular}<Enter><++><Esc>3k/]{<Enter>2li

" sh keybinding
autocmd BufRead,BufNewFile *.sh setlocal filetype=sh
autocmd FileType sh inoremap ;;ca read<space>n<Enter>case<space>$n<space>in<Enter><Enter>*)<++><Enter>&&<esc>hr;lr;oesac<Enter><++><esc>4ki<tab>
autocmd FileType sh inoremap ;;ci )<tab><++><Enter>&&<esc>hr;lr;o<++><esc>2k0la
autocmd FileType sh inoremap ;;w while<space>;<space>do<Enter><++><Enter>done<Enter><++><esc>3k0wi
autocmd FileType sh inoremap ;;f for<space><space>in<space><++>;<space>do<Enter><++><Enter>done<esc>2k04li

" md keybindings
autocmd BufRead,BufNewFile *.md setlocal filetype=md
autocmd FileType md inoremap ;;c <Esc>o```<Enter><Enter>```<Enter><++><Esc>2ki
autocmd FileType md inoremap ;;i ![](image/<++>)<Esc>12hi
autocmd FileType md inoremap ;;l [](<++>)<Esc>6hi
autocmd FileType md inoremap ;;el [](http://<++>)<Esc>13hi
