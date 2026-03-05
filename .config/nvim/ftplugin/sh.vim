"case/switch statement
inoremap <buffer> <leader>ca read<space>n<Enter>case<space>$n<space>in<Enter><Enter>*)<++><Enter>&&<esc>hr;lr;oesac<Enter><++><esc>4ki<tab>
"case item
inoremap <buffer> <leader>ci )<tab><++><Enter>&&<esc>hr;lr;o<++><esc>2k0la
"while loop
inoremap <buffer> <leader>w while<space>;<space>do<Enter><++><Enter>done<Enter><++><esc>3k0wi
"for loop
inoremap <buffer> <leader>f for<space><space>in<space><++>;<space>do<Enter><++><Enter>done<esc>2k04li
"comment out selected text
vnoremap <buffer> <leader>c <esc>`<i:<space>'<space><cr><esc>`>a<cr>'<esc>


