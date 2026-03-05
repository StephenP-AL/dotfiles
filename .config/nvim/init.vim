" Plugin Manager
call plug#begin('~/.local/share/nvim/plugged')

Plug 'nanotech/jellybeans.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons' 
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'

call plug#end()

" Basic Settings

syntax on
filetype plugin indent on
set number
let mapleader = ";;"

set termguicolors
colorscheme jellybeans

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
    cmd = { 
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--completion-style=detailed",
        "--header-insertion=iwyu",
    },
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
nnoremap <leader>d :lua vim.diagnostic.open_float()<CR>

" Open a terminal in a bottom split
lua << EOF

local term_buf = nil
local term_win = nil
function _G.toggle_bottom_terminal()
  if term_win and vim.api.nvim_win_is_valid(term_win) then
    vim.api.nvim_win_close(term_win, true)
    term_win = nil
    return
  end

  vim.cmd('botright 11split')
  vim.cmd('terminal')
  term_buf = vim.api.nvim_get_current_buf()
  term_win = vim.api.nvim_get_current_win()
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
lua << EOF
vim.keymap.set("n", "gd", function()
  local params = vim.lsp.util.make_position_params()

  vim.lsp.buf_request(0, "textDocument/definition", params, function(err, result)
    if err or not result or vim.tbl_isempty(result) then
      print("No definition found")
      return
    end

    local def = result[1]
    local uri = def.uri or def.targetUri
    local filename = vim.uri_to_fname(uri)
    local current = vim.api.nvim_buf_get_name(0)

    if filename ~= current then
      vim.cmd("tabnew " .. vim.fn.fnameescape(filename))
    end

    vim.api.nvim_win_set_cursor(0, {
      def.range.start.line + 1,
      def.range.start.character
    })
  end)
end, { silent = true })
EOF

lua << EOF
vim.keymap.set("n", "gD", function()
  local params = vim.lsp.util.make_position_params()

  vim.lsp.buf_request(0, "textDocument/declaration", params, function(err, result)
    if err or not result or vim.tbl_isempty(result) then
      print("No declaration found")
      return
    end

    local def = result[1]
    local uri = def.uri or def.targetUri
    local filename = vim.uri_to_fname(uri)
    local current = vim.api.nvim_buf_get_name(0)

    if filename ~= current then
      vim.cmd("tabnew " .. vim.fn.fnameescape(filename))
    end

    vim.api.nvim_win_set_cursor(0, {
      def.range.start.line + 1,
      def.range.start.character
    })
  end)
end, { silent = true })
EOF

lua << EOF
vim.keymap.set("n", "gi", function()
  local params = vim.lsp.util.make_position_params()

  vim.lsp.buf_request(0, "textDocument/implementation", params, function(err, result)
    if err or not result or vim.tbl_isempty(result) then
      print("No implementation found")
      return
    end

    local def = result[1]
    local uri = def.uri or def.targetUri
    local filename = vim.uri_to_fname(uri)
    local current = vim.api.nvim_buf_get_name(0)

    if filename ~= current then
      vim.cmd("tabnew " .. vim.fn.fnameescape(filename))
    end

    vim.api.nvim_win_set_cursor(0, {
      def.range.start.line + 1,
      def.range.start.character
    })
  end)
end, { silent = true })
EOF

lua << EOF
vim.keymap.set("n", "gt", function()
  local params = vim.lsp.util.make_position_params()

  vim.lsp.buf_request(0, "textDocument/typeDefinition", params, function(err, result)
    if err or not result or vim.tbl_isempty(result) then
      print("No type definition found")
      return
    end

    local def = result[1]
    local uri = def.uri or def.targetUri
    local filename = vim.uri_to_fname(uri)
    local current = vim.api.nvim_buf_get_name(0)

    if filename ~= current then
      vim.cmd("tabnew " .. vim.fn.fnameescape(filename))
    end

    vim.api.nvim_win_set_cursor(0, {
      def.range.start.line + 1,
      def.range.start.character
    })
  end)
end, { silent = true })
EOF

lua << EOF
vim.keymap.set("n", "gr", function()
  vim.lsp.buf.references(nil, {
    on_list = function(options)
      -- Open a new tab
      vim.cmd("tabnew")

      -- Populate quickfix
      vim.fn.setqflist({}, " ", options)

      -- Open quickfix window
      vim.cmd("copen")
    end
  })
end, { silent = true })
EOF

nnoremap <silent> K :lua vim.lsp.buf.hover()<cr>

"Spell check
map <F2> :setlocal spell! spelllang=en_us<CR>
inoremap <F2> <Esc>:setlocal spell! spelllang=en_us<CR>a
 
"Line numbers
noremap <F3> :set invnumber!<CR>
inoremap <F3> <C-O>:set invnumber!<CR>

nnoremap <F4> :NvimTreeToggle<CR>

" Save with sudo"
cmap w!! w !sudo tee > /dev/null %

" Session quicksave
map <F11> :mks!<space>quicksave.vim<cr>
inoremap <F11> <esc>:mks!<space>quicksave.vim<cr>a

" Center on search
nnoremap n	nzz
nnoremap N	Nzz
"
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


" Nvim DAP for C++ 
"-------------------------------
lua << EOF
local dap = require('dap')

-- Adapter: VSCode C++ extension (OpenDebugAD7)
dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '/path/to/OpenDebugAD7',  -- <-- set this to your cpptools extension path
}

-- C++ configuration
dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = true,
    setupCommands = {
      {
        text = '-enable-pretty-printing',
        description = 'enable pretty printing',
        ignoreFailures = false
      },
    },
  },
}

-- Use same configuration for C
dap.configurations.c = dap.configurations.cpp

-- Keymaps for debugging
vim.keymap.set('n', '<F5>', require'dap'.continue, { silent = true })
vim.keymap.set('n', '<F6>', require'dap'.toggle_breakpoint, { silent = true })
vim.keymap.set('n', '<F7>', require'dap'.step_into, { silent = true })
vim.keymap.set('n', '<F8>', require'dap'.step_over, { silent = true })
EOF

lua << EOF
local dap = require('dap')
vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointCondition', {text='⚠️', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='▶️', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='❌', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapLogPoint', {text='ℹ️', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapWatchpoint', {text='👁️', texthl='', linehl='', numhl=''})

vim.fn.sign_define("DiagnosticSignError", {text = "✗", texthl = "DiagnosticSignError"})
vim.fn.sign_define("DiagnosticSignWarn",  {text = "⚠️", texthl = "DiagnosticSignWarn"})
vim.fn.sign_define("DiagnosticSignInfo",  {text = "ℹ️", texthl = "DiagnosticSignInfo"})
vim.fn.sign_define("DiagnosticSignHint",  {text = "💡", texthl = "DiagnosticSignHint"})
EOF

lua << EOF
require("nvim-dap-virtual-text").setup({
  enabled = true,               -- enable virtual text
  enabled_commands = true,      -- add DAP commands for virtual text
  highlight_changed_variables = true,
  highlight_new_as_changed = true,
  show_stop_reason = true,      -- show reason for stop (e.g., breakpoint hit)
  commented = false,            -- show virtual text as comments
  only_first_definition = false, -- show all occurrences
})
EOF
