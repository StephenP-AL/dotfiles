" Plugin Manager
call plug#begin('~/.local/share/nvim/plugged')

Plug 'nanotech/jellybeans.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'kyazdani42/nvim-web-devicons' 

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

" Open a terminal in a bottom split
lua << EOF
function _G.toggle_bottom_terminal()
  -- open bottom split
  vim.cmd('botright 11split')
  -- open terminal in the new split
  vim.cmd('terminal')
end
EOF

lua << EOF
require'nvim-tree'.setup {
  hijack_cursor = true,       -- keeps cursor on the file when navigating
  update_focused_file = {
    enable = true,            -- highlight and focus current file
    update_cwd = true,
  },
  view = {
    width = 30,
    side = 'left',
  },
}
EOF

" Map F9 to call the function
nnoremap <F9> :lua _G.toggle_bottom_terminal()<CR>i
inoremap <F9> <Esc>:lua _G.toggle_bottom_terminal()<CR>i

" LSP Keymaps 
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
"map <F9> :term <cr>i
"inoremap <F9> <esc>:term<cr>i

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

"File browser
"let g:netrw_banner = 0
"let g:netrw_browse_split = 3
"let g:netrw_winsize = 20 
"let g:netrw_liststyle = 3
"
""autocmd FileType netrw nmap <buffer> <F4> :q<cr>
"nnoremap <F4> <esc>:Vexplore!<cr>
nnoremap <F4> :NvimTreeToggle<CR>
