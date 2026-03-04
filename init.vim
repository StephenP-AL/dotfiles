" Plugin Manager

call plug#begin('~/.local/share/nvim/plugged')

Plug 'nanotech/jellybeans.vim'
Plug 'neovim/nvim-lspconfig'
"testing
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'

call plug#end()

" Basic Settings

syntax on
filetype plugin indent on
set number
let mapleader = ";;"

set termguicolors
colorscheme jellybeans

set splitright
set splitbelow

set clipboard=unnamedplus
set mouse=a
set hidden
set updatetime=300
set signcolumn=yes

set expandtab
set tabstop=4
set shiftwidth=4

set completeopt=menu,menuone,noinsert

" LSP Setup (clangd)

lua << EOF
vim.lsp.config('clangd', {
    cmd = { "clangd" },
})
vim.lsp.enable('clangd')
EOF
"Testing
lua << EOF
local cmp = require('cmp')

cmp.setup({
  sources = {
    { name = 'nvim_lsp' },
  },
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
  },
})
EOF

"
"lua << EOF
"vim.api.nvim_create_autocmd("LspAttach", {
"  callback = function(args)
"    vim.bo[args.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
"
"    -- Auto-trigger completion after typing characters
"    vim.api.nvim_create_autocmd("TextChangedI", {
"      buffer = args.buf,
"      callback = function()
"        if vim.fn.pumvisible() == 0 then
"          vim.api.nvim_feedkeys(
"            vim.api.nvim_replace_termcodes("<C-x><C-o>", true, false, true),
"            "n",
"            true
"          )
"        end
"      end,
"    })
"  end,
"})
"EOF
"


" LSP Keymaps (DO NOT conflict with yours)
nnoremap <silent> gd :lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K  :lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gr :lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi :lua vim.lsp.buf.implementation()<CR>

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

" Center on search
nnoremap n	nzz
nnoremap N	Nzz

"Find code reentry tag
"inoremap <leader><space> <Esc>/<++><Enter>"_4cl

"open terminal
map <F9> :term <cr>i
inoremap <F9> <esc>:term<cr>i

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

"---------------------------------------------------------------
" ---Tabs
"Unix new tab
nmap <silent> <Tab>o :tabnew `dirname %`<CR>

"Cycle tabs
nnoremap <Tab>h :tabp<CR>
nnoremap <Tab>l :tabn<CR>

"Move tabs
nnoremap <silent> <Tab>j :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <Tab>k :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>


"---------------------------------------------------------------
" ---Auto close tags

" --Parenthesis
"skips over ) if ) is next character
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
"place cursor after closing )
inoremap <leader>)	<Esc>/)<Enter>a
"enclose current word
inoremap vv(	<esc>bi(<esc>ea)
"enclose current line
inoremap vvv(	<esc>0i(<esc>A)

" --Double quote
"inoremap ""	""<Left>
"skips over " if " is next character
inoremap <expr> "  strpart(getline('.'), col('.')-1, 1) == '"' ? "\<Right>" : '"'
"place cursor after next "
inoremap <leader>"	<Esc>/"<Enter>a
"enclose current word
inoremap vv" <esc>bi"<esc>ea"
"enclose current line
inoremap vvv" <esc>0i"<esc>A" 

" --Braces
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
