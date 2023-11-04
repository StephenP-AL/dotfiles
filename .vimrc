syntax on
set nocompatible
"set rtp+=~/.vim/tabnine-vim
"set rtp+=~/.vim/bundle/YouCompleteMe
packadd YouCompleteMe
filetype plugin indent on
set number
let mapleader = ";;"
hi! link netrwMarkFile Search

"call plug#begin()
"Plug 'codota/tabnine-vim'
"call plug#end()

colorscheme jellybeans
"---------------------------------------------------------------
"---------------------------------------------------------------
" ---Global keybindings

"Spell check
map <F2> :setlocal spell! spelllang=en_us<CR>
inoremap <F2> <Esc>:setlocal spell! spelllang=en_us<CR>a
 
"Line numbers
noremap <F3> :set invnumber!<CR>
inoremap <F3> <C-O>:set invnumber!<CR>

" Save with sudo"
cmap w!! w !sudo tee > /dev/null %

" Session quicksave
map <F11> :mks!<space>quicksave.vim<cr>
inoremap <F11> <esc>:mks!<space>quicksave.vim<cr>a

map <F12> :execute "mksession! " . vimoirepath <Bar> echo "Session Saved"<cr>

map <F10> :echo "Using vimrc binding" <bar> echo "fart"<cr>

" Center on search
nnoremap n	nzz
nnoremap N	Nzz

"Find code reentry tag
"inoremap <leader><space> <Esc>/<++><Enter>4xa
inoremap <leader><space> <Esc>/<++><Enter>"_4cl

"open terminal
map <F9> :ter<cr>
inoremap <F9> <esc>:ter<cr>

"---------------------------------------------------------------
" ---Split panes 
set splitright
set splitbelow
	
" vertical split
nnoremap <c-w>" :sp `dirname %`<cr> 
inoremap <c-w>" <esc>:sp `dirname %`<cr> 
" horizontal spilt
nnoremap <c-w>% :vsplit `dirname %`<cr> 
inoremap <c-w>% <esc>:vsplit `dirname %`<cr> 

" resize panes
nnoremap <c-s-k> :resize +2<CR>
nnoremap <c-s-j> :resize -2<CR>
nnoremap <c-s-h> :vertical resize -2<CR>
nnoremap <c-s-l> :vertical resize +2<CR>

inoremap <c-s-k> <esc>:resize +2<CR>a
inoremap <c-s-j> <esc>:resize -2<CR>a
inoremap <c-s-h> <esc>:vertical resize -2<CR>a
inoremap <c-s-l> <esc>:vertical resize +2<CR>a


""nnoremap <Up>    :resize +2<CR>
""nnoremap <Down>  :resize -2<CR>
""nnoremap <Left>  :vertical resize -2<CR>
""nnoremap <Right> :vertical resize +2<CR>

"---------------------------------------------------------------
" ---Tabs
"Unix new tab
nmap <silent> <F4> :tabnew `dirname %`<CR>
nmap <silent> <Tab>o :tabnew `dirname %`<CR>
"Windows new tab
"nmap <silent> <F4> :tabnew  %:p:h:gs?\/?\\\\\\?<CR>

"Cycle tabs
nnoremap <F5> :tabp<CR>
nnoremap <Tab>h :tabp<CR>

nnoremap <F8> :tabn<CR>
nnoremap <Tab>l :tabn<CR>

"Move tabs
nnoremap <silent> <F6> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <F7> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>

nnoremap <silent> <Tab>j :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <Tab>k :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>


"---------------------------------------------------------------
" ---Auto close tags

" --Parenthesis
inoremap (	()<Left>
"inoremap ((	(
inoremap ()	()
"skips over ) if ) is next character
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
"place cursor after closing )
inoremap <leader>)	<Esc>/)<Enter>a
"enclose current word
inoremap vv(	<esc>bi(<esc>ea)
"enclose current line
inoremap vvv(	<esc>0i(<esc>A)

" --Double quote
inoremap ""	""<Left>
"skips over " if " is next character
inoremap <expr> "  strpart(getline('.'), col('.')-1, 1) == '"' ? "\<Right>" : '"'
"place cursor after next "
inoremap <leader>"	<Esc>/"<Enter>a
"enclose current word
inoremap vv" <esc>bi"<esc>ea"
"enclose current line
inoremap vvv" <esc>0i"<esc>A" 

" --Braces
inoremap {      {}<Left>

inoremap {<CR>  {<CR>}<Esc>O
"inoremap {{     {
inoremap {}     {}
"skips over } if { is next character
inoremap <expr> }  strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
"place cursor after closing }
inoremap <leader>}	<Esc>/}<Enter>a
"enclose current word
inoremap vv{	<esc>bi{<esc>ea}
"enclose current line
inoremap vvv{	<esc>0i{<esc>A}

"visual mode, enclose selected text
vnoremap <leader>" <esc>`>a"<esc>`<i"<esc>
vnoremap <leader>( <esc>`>a)<esc>`<i(<esc>
vnoremap <leader>{ <esc>`>a}<esc>`<i{<esc>
"---------------------------------------------------------------
"---------------------------------------------------------------
" ---File specific keybindings


"---------------------------------------------------------------
" ---C/C++ keybindings
autocmd BufRead,BufNewFile *.c setlocal filetype=cpp
"for loop
autocmd FileType cpp inoremap <leader>f for(){<Enter><++><Enter>}<Enter><++><Esc>3k$T(i
"while loop
autocmd FileType cpp inoremap <leader>w while(){<Enter><space><++><Enter>}<Enter><++><Esc>3k$T(i
"do while loop
autocmd FileType cpp inoremap <leader>do do{<Enter><Enter>}while(<++>);<Enter><++><Esc>2k$i
"if statement
autocmd FileType cpp inoremap <leader>if if(){<Enter><++><Enter>}<Enter><++><Esc>3k$T(i
"else statement
autocmd FileType cpp inoremap <leader>el else{<Enter><Enter>}<Enter><++><Esc>2k$i<tab>
"else if statement
autocmd FileType cpp inoremap <leader>ei else<space>if(){<Enter><++><Enter>}<Enter><++><Esc>3k$T(i
"debug code section
autocmd FileType cpp inoremap <leader>de #ifdef<space>DEBUG<Enter><Enter>#endif<Enter><++><Esc>2k$i
"debug message
autocmd FileType cpp inoremap <leader>dm #ifdef<space>DEBUG<Enter>printf("%s\n","---DEBUG---");<Enter>#endif<Enter><++><Esc>3k/%s<Enter>lli
"another debug message
autocmd FileType cpp inoremap <leader>d1 #ifdef<space>DEBUG1<Enter>printf("%s\n","---DEBUG1---");<Enter>#endif<Enter><++><Esc>3k/%s<Enter>lli
"another debug message
autocmd FileType cpp inoremap <leader>d2 #ifdef<space>DEBUG2<Enter>printf("%s\n","---DEBUG2---");<Enter>#endif<Enter><++><Esc>3k/%s<Enter>lli
"a comment section deliniated by lines of hyphens
autocmd FileType cpp inoremap <leader>- //-------------------------------------------<Enter><Enter>-------------------------------------------<Enter><Esc>02xi<++><Esc>2kA<space>
"Encloses selected section in comment tags
autocmd FileType cpp vnoremap <leader>c <esc>`>a*/<esc>`<i/*<esc>
"---------------------------------------------------------------
" ---GOlang keybinding
autocmd BufRead, BufNewFile *.go setlocal filetype=go
"for loop
autocmd FileType go inoremap <leader>f for<space>{<Enter><++><Enter>}<Enter><++><Esc>3k0ea<space>
"if statement
autocmd FileType go inoremap <leader>if if<space>{<Enter><++><Enter>}<Enter><++><Esc>3k0ea<space>
"else if statement
autocmd FileType go inoremap <leader>el else<space>{<Enter>}<Enter><++><Esc>2ko
"Encloses selected section in comment tags
autocmd FileType go vnoremap <leader>c <esc>`>a*/<esc>`<i/*<esc>

"---------------------------------------------------------------
" ---LaTeX keybinding
autocmd FileType tex inoremap <leader>tempa \documentclass{article}<Enter>\title{<++>}<Enter>\author{Stephen Pate}<Enter>\usepackage[margin=1in]{geometry}<Enter><Enter>\begin{document}<Enter>\maketitle<Enter><++><Enter>\end{document}<Esc>8k15li
autocmd BufRead,BufNewFile *.tex setlocal filetype=tex
autocmd FileType tex inoremap <leader>item \begin{itemize}<Enter><Enter>\end{itemize}<Enter><++><Esc>2ki\item<space>
autocmd FileType tex inoremap <leader>enum \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><++><Esc>2ki\item<space>
autocmd FileType tex inoremap <leader>desc \begin{description}<Enter><Enter>\end{description}<Esc>2ki\item<space>
autocmd FileType tex inoremap <leader>I \item<space>
autocmd FileType tex inoremap <leader>eq \begin{equation}<Enter><Enter>\end{equation}<Enter><++><Esc>2ki
autocmd FileType tex inoremap <leader>tab \begin{tabular}[t]{}<Enter><++><Enter>\end{tabular}<Enter><++><Esc>3k/]{<Enter>2li
autocmd FileType tex inoremap <leader>{ \{\}<++><Esc>5hi
"Bold selected text
autocmd FileType tex vnoremap <leader>b <esc>`>a}<esc>`<i\textbf{<esc>
"italicize selected text
autocmd FileType tex vnoremap <leader>i <esc>`>a}<esc>`<i\textit{<esc>
"math tag selected text
autocmd FileType tex vnoremap <leader>$ <esc>`>a$<esc>`<i$<esc>

"---------------------------------------------------------------
" ---sh keybinding
autocmd BufRead,BufNewFile *.sh setlocal filetype=sh
"case/switch statement
autocmd FileType sh inoremap <leader>ca read<space>n<Enter>case<space>$n<space>in<Enter><Enter>*)<++><Enter>&&<esc>hr;lr;oesac<Enter><++><esc>4ki<tab>
"case item
autocmd FileType sh inoremap <leader>ci )<tab><++><Enter>&&<esc>hr;lr;o<++><esc>2k0la
"while loop
autocmd FileType sh inoremap <leader>w while<space>;<space>do<Enter><++><Enter>done<Enter><++><esc>3k0wi
"for loop
autocmd FileType sh inoremap <leader>f for<space><space>in<space><++>;<space>do<Enter><++><Enter>done<esc>2k04li
"comment out selected text
autocmd FileType sh vnoremap <leader>c <esc>`<i:<space>'<space><cr><esc>`>a<cr>'<esc>


"---------------------------------------------------------------
" ---md keybindings
autocmd BufRead,BufNewFile *.md setlocal filetype=md
autocmd FileType md inoremap <leader>c <Esc>o```<Enter><Enter>```<Enter><++><Esc>2ki
autocmd FileType md inoremap <leader>i ![](image/<++>)<Esc>12hi
autocmd FileType md inoremap <leader>l [](<++>)<Esc>6hi
autocmd FileType md inoremap <leader>el [](http://<++>)<Esc>13hi


"---------------------------------------------------------------
" ---ARM Assembly keybindings
autocmd BufRead,BufNewFile *.s setlocal filetype=s
"for loop
autocmd FileType s inoremap <leader>f <esc>0d$i@<esc>pomov<space>r0,<space>#<tab>@Iterations<cr><esc>pAStart:<tab>@Beginning<space>of<space>the<space>loop<cr><++><cr>subs,<space>r0,<space>#1<tab>@Decrement<space>the<space>counter<cr>bne<space><esc>pAStart<esc>4k03wa
"add string to data
autocmd FileType s inoremap <leader>st <esc>/.data<Enter>o<cr>.balign<space>4<cr>str:<space>.asciz<space>"<++>\n"<esc>k02li
autocmd FileType s nnoremap <leader>st <esc>/.data<Enter>o<cr>.balign<space>4<cr>str:<space>.asciz<space>"<++>\n"<esc>k02li
