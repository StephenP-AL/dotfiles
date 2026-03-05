"for loop
inoremap <buffer> <leader>f for(){<Enter><++><Enter>}<Enter><++><Esc>3k$T(i
"while loop
inoremap <buffer> <leader>w while(){<Enter><space><++><Enter>}<Enter><++><Esc>3k$T(i
"do while loop
inoremap <buffer> <leader>do do{<Enter><Enter>}while(<++>);<Enter><++><Esc>2k$i
"if statement
inoremap <buffer> <leader>if if(){<Enter><++><Enter>}<Enter><++><Esc>3k$T(i
"else statement
inoremap <buffer> <leader>el else{<Enter><Enter>}<Enter><++><Esc>2k$i<tab>
"else if statement
inoremap <buffer> <leader>ei else<space>if(){<Enter><++><Enter>}<Enter><++><Esc>3k$T(i
"debug code section
inoremap <buffer> <leader>de #ifdef<space>DEBUG<Enter><Enter>#endif<Enter><++><Esc>2k$i
"debug message
inoremap <buffer> <leader>dm #ifdef<space>DEBUG<Enter>printf("%s\n","---DEBUG---");<Enter>#endif<Enter><++><Esc>3k/%s<Enter>lli
"another debug message
inoremap <buffer> <leader>d1 #ifdef<space>DEBUG1<Enter>printf("%s\n","---DEBUG1---");<Enter>#endif<Enter><++><Esc>3k/%s<Enter>lli
"another debug message
inoremap <buffer> <leader>d2 #ifdef<space>DEBUG2<Enter>printf("%s\n","---DEBUG2---");<Enter>#endif<Enter><++><Esc>3k/%s<Enter>lli
"Encloses selected section in comment tags
vnoremap <buffer> <leader>c <esc>`>a*/<esc>`<i/*<esc>
"
