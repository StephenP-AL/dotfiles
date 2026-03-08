" ============================================================
"  .vimrc — C++ / Qt Developer Config
"  Vim 9.2 | Fedora
"  Leader: ;;  |  Plugins: vim-plug
" ============================================================
"
" Other installs :
" clang clang-tools-extra cmake odejs npm python3-pip ripgrep python3-devel
" llvm-devel clang-devel gdb 
"
" pip install dubugpy --user 
"
" vim-plug:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" in vim --  :PlugInstall
"
" Compile YCM:
" cd ~/.vim/plugged/YouCompleteMe; python3 install.py --clangd-completer
"
" " ─── PLUGIN MANAGER (vim-plug) ───────────────────────────────
call plug#begin('~/.vim/plugged')

" File browser
Plug 'preservim/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'ryanoasis/vim-devicons'              " Icons in NERDTree (needs a Nerd Font)

" Fuzzy finder / project-wide search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Autocompletion + GoTo definition + find references (clangd backend)
Plug 'ycm-core/YouCompleteMe', { 'do': 'python3 install.py --clangd-completer' }

" Debugging
Plug 'puremourning/vimspector'

" Colorscheme
Plug 'nanotech/jellybeans.vim'

" Status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Git integration (optional but very handy)
Plug 'tpope/vim-fugitive'

" Syntax highlighting improvements
Plug 'sheerun/vim-polyglot'

" Comment toggling
Plug 'tpope/vim-commentary'

" Auto pairs (brackets, parens, quotes)
Plug 'jiangmiao/auto-pairs'

" Display tags/symbols in a sidebar
Plug 'preservim/tagbar'

call plug#end()
" ─────────────────────────────────────────────────────────────


" ─── GENERAL SETTINGS ────────────────────────────────────────
set nocompatible
filetype plugin indent on
syntax enable

set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8

set number                    " Line numbers
"set relativenumber            " Relative line numbers
set cursorline                " Highlight current line
set showmatch                 " Highlight matching brackets
set wildmenu                  " Better command completion
set wildmode=longest:full,full
set hidden                    " Allow unsaved buffers in background
set splitright                " Vertical splits open to the right
set splitbelow                " Horizontal splits open below
set laststatus=2              " Always show status line
set scrolloff=8               " Keep 8 lines visible above/below cursor
set signcolumn=yes            " Always show sign column (for YCM diagnostics)
set updatetime=300            " Faster update for YCM diagnostics
set shortmess+=c              " Don't pass messages to ins-completion-menu
set backspace=indent,eol,start

" Tabs / Indentation
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set smartindent

" Search
set incsearch
set hlsearch
set ignorecase
set smartcase

" Backup / swap (keep them out of working dirs)
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//
set undofile
silent! call mkdir(expand('~/.vim/backup'), 'p')
silent! call mkdir(expand('~/.vim/swap'),   'p')
silent! call mkdir(expand('~/.vim/undo'),   'p')

" Mouse support
set mouse=a
" ─────────────────────────────────────────────────────────────


" ─── COLORSCHEME ─────────────────────────────────────────────
set t_Co=256
set background=dark
colorscheme jellybeans
" ─────────────────────────────────────────────────────────────


" ─── LEADER KEY ──────────────────────────────────────────────
" Using ";;" as the leader key.
" vim only allows a single character as mapleader, so we map
" ";;" explicitly as a prefix for all custom bindings instead.
" All custom mappings below use ";;" as the prefix.
" ─────────────────────────────────────────────────────────────


" ─── NERDTREE (File Browser) ─────────────────────────────────
" Toggle NERDTree with F4
"nnoremap <F4> :NERDTreeToggle<CR>
nnoremap <F4> :NERDTreeTabsToggle<CR>

"Open files in a new tab by default
let NERDTreeMapOpenInTab = '<CR>'       " Enter opens in new tab
let NERDTreeMapOpenInTabSilent = 't'    " 't' opens silently in new tab

let NERDTreeShowHidden = 1             " Show dotfiles
let NERDTreeMinimalUI = 1              " Cleaner UI
let NERDTreeAutoDeleteBuffer = 1       " Auto-delete buffer when file is deleted
let NERDTreeQuitOnOpen = 0             " Keep tree open after opening a file
let NERDTreeIgnore = ['\.o$', '\.d$', '\.pyc$', '__pycache__', '\.git$', 'build$']

" Mirror tree in all tabs
let g:nerdtree_tabs_open_on_console_startup = 1   " open on startup
let g:nerdtree_tabs_synchronize_view = 1           " sync scroll & cursor
let g:nerdtree_tabs_synchronize_focus = 1          " sync focus

" If NERDTree is the only window left, close vim
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 &&
    \ exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" ─────────────────────────────────────────────────────────────


" ─── YOUCOMPLETEME (Autocomplete + GoTo + References) ────────
" Use clangd for C/C++
let g:ycm_clangd_uses_ycmd_caching = 0
let g:ycm_clangd_binary_path = exepath('clangd')

" Disable YCM's own diagnostic signs (we'll use its virtual text)
let g:ycm_show_diagnostics_ui = 1
let g:ycm_enable_diagnostic_signs = 1
let g:ycm_enable_diagnostic_highlighting = 1
let g:ycm_echo_current_diagnostic = 1

" Auto-close preview window after completion
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

" Min chars before triggering completion
let g:ycm_min_num_of_chars_for_completion = 2

" Seed identifiers from comments and strings
let g:ycm_collect_identifiers_from_comments_and_strings = 1

" Extra config file (per-project, for compile flags fallback)
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0

" ── GoTo bindings (;;g prefix) ──
" Go to definition (new tab if different file)
nnoremap gd :tab YcmCompleter GoToDefinition<CR>

" Go to declaration (new tab if different file)
nnoremap gD :tab YcmCompleter GoToDeclaration<CR>

" Go to definition or declaration (smart)
nnoremap ;;gg :tab YcmCompleter GoTo<CR>

" ── Show all references ──
nnoremap gr :YcmCompleter GoToReferences<CR>

" ── Show documentation/type ──
nnoremap K  :YcmCompleter GetDoc<CR>
nnoremap ;;t  :YcmCompleter GetType<CR>

" ── Rename symbol ──
nnoremap ;;rn :YcmCompleter RefactorRename<Space>

" ── Fix diagnostic / apply fixit ──
nnoremap ;;fx :YcmCompleter FixIt<CR>

" Navigate diagnostics
nnoremap ;;]  :lnext<CR>
nnoremap ;;[  :lprev<CR>
" ─────────────────────────────────────────────────────────────


" ─── FZF (Project-wide Search) ───────────────────────────────
" Project-wide text search with ripgrep (;;/)
nnoremap ;;/  :Rg<Space>

" Search word under cursor project-wide (;;*)
nnoremap ;;*  :Rg <C-R><C-W><CR>

" Fuzzy file finder (;;f)
nnoremap ;;f  :Files<CR>

" Search open buffers (;;b)
nnoremap ;;b  :Buffers<CR>

" Search lines in current file (;;l)
nnoremap ;;l  :BLines<CR>

" Search all tags/symbols (;;s)
nnoremap ;;s  :Tags<CR>

" Configure FZF to open results in a new tab
let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }

" FZF layout — floating window
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }

" Use ripgrep for :Files (respects .gitignore)
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git"'
" ─────────────────────────────────────────────────────────────


" ─── VIMSPECTOR (Debugging) ──────────────────────────────────
" Enable Vimspector
let g:vimspector_enable_mappings = 'NONE'    " We define our own mappings

" Debugging keybindings (;;d prefix)
nnoremap ;;dl  :call vimspector#Launch()<CR>             " Launch / Start debug
nnoremap ;;dq  :call vimspector#Reset()<CR>              " Stop / Quit debug
nnoremap ;;dc  :call vimspector#Continue()<CR>           " Continue
nnoremap ;;db  :call vimspector#ToggleBreakpoint()<CR>   " Toggle breakpoint
nnoremap ;;dB  :call vimspector#ToggleConditionalBreakpoint()<CR>
nnoremap ;;do  :call vimspector#StepOver()<CR>           " Step over
nnoremap ;;di  :call vimspector#StepInto()<CR>           " Step into
nnoremap ;;dO  :call vimspector#StepOut()<CR>            " Step out
nnoremap ;;dr  :call vimspector#RunToCursor()<CR>        " Run to cursor
nnoremap ;;dw  :call vimspector#AddWatch('')<Left><Left> " Add watch expression
nnoremap ;;de  :call vimspector#Evaluate('')<Left><Left> " Evaluate expression
nnoremap ;;dp  :call vimspector#Pause()<CR>              " Pause
nnoremap ;;dR  :call vimspector#Restart()<CR>            " Restart
nnoremap ;;dx  :call vimspector#ClearBreakpoints()<CR>   " Clear all breakpoints

" Show vimspector windows
nnoremap ;;dv  :call vimspector#ShowOutput( 'Console' )<CR>
" ─────────────────────────────────────────────────────────────


" ─── TAGBAR (Symbol Browser) ─────────────────────────────────
" Toggle symbol browser with F3
nnoremap <F3> :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_sort = 0
" ─────────────────────────────────────────────────────────────


" ─── AIRLINE ─────────────────────────────────────────────────
let g:airline_theme = 'jellybeans'
let g:airline#extensions#tabline#enabled = 1        " Show tabs at top
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#ycm#enabled = 1            " Show YCM errors in status
let g:airline_powerline_fonts = 1                   " Requires a Nerd Font
" ─────────────────────────────────────────────────────────────


" ─── TAB NAVIGATION ──────────────────────────────────────────
nnoremap <Tab>     :tabnext<CR>
nnoremap <S-Tab>   :tabprev<CR>

" Tab navigation with leader (;;1 through ;;9)
for i in range(1, 9)
    execute 'nnoremap ;;' . i . ' ' . i . 'gt'
endfor
" ─────────────────────────────────────────────────────────────


" ─── MISCELLANEOUS KEYBINDINGS ───────────────────────────────
" Clear search highlight
nnoremap ;;h  :nohlsearch<CR>

" Toggle paste mode
set pastetoggle=<F2>

" Better window navigation (without leader)
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Move lines up/down in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Keep cursor centered when searching
nnoremap n nzzzv
nnoremap N Nzzzv
" ─────────────────────────────────────────────────────────────


" ─── FILETYPE SPECIFIC ───────────────────────────────────────
" C / C++
autocmd FileType c,cpp setlocal tabstop=4 shiftwidth=4 expandtab
autocmd FileType c,cpp setlocal commentstring=//\ %s

" QML (Qt)
autocmd BufNewFile,BufRead *.qml setfiletype qml

" Python
autocmd FileType python setlocal tabstop=4 shiftwidth=4 expandtab

" JavaScript
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 expandtab

" SQL
autocmd FileType sql setlocal tabstop=4 shiftwidth=4 expandtab

" Bash
autocmd FileType sh setlocal tabstop=4 shiftwidth=4 expandtab

" CMakeLists
autocmd BufNewFile,BufRead CMakeLists.txt setfiletype cmake
autocmd BufNewFile,BufRead *.cmake        setfiletype cmake

" Meson
autocmd BufNewFile,BufRead meson.build    setfiletype meson
" ─────────────────────────────────────────────────────────────


" ─── YCM EXTRA CONF (fallback for projects without compile_commands.json) ─
" Creates a minimal ~/.vim/.ycm_extra_conf.py automatically
if !filereadable(expand('~/.vim/.ycm_extra_conf.py'))
    call writefile([
        \ 'def Settings(**kwargs):',
        \ '    return {',
        \ '        "flags": [',
        \ '            "-x", "c++",',
        \ '            "-std=c++17",',
        \ '            "-Wall",',
        \ '            "-Wextra",',
        \ '            "-I/usr/include",',
        \ '            "-I/usr/local/include",',
        \ '        ],',
        \ '    }',
        \ ], expand('~/.vim/.ycm_extra_conf.py'))
endif
" ─────────────────────────────────────────────────────────────
