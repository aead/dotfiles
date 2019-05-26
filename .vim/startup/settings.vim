set nocompatible

" Show shortcut commands in status line
set showcmd

" Show line numbers
set number

" Show ruler {line, column, virt. column} number
set ruler

" Show cursor line
set cursorline

" Don't auto. wrap lines 
set nowrap

" Convert tabs to spaces
set expandtab

" Insert 4 spaces for one tab
set tabstop=4

" Insert 4 spaces for indentation
set shiftwidth=4

" Disable swap and backup files
set noswapfile
set nobackup
set nowritebackup

" Set encoding to UTF-8
set enc=utf-8

" Always show status line
set laststatus=2

" Enable incremental search (search while typing)
set incsearch

" Show command completion options
set wildmenu

" Don't show menu detail
set completeopt=longest,menuone

" Reload buffer if underlying file has changed
set autoread

" Use the system clipboard for copy/paste (requries vim-gtk3 package).
set clipboard=unnamedplus

" Enable spell checking for git commit messages
autocmd FileType gitcommit setlocal spell

" Change color of auto-complete popup menu
highlight Pmenu ctermbg=gray guibg=gray

" Ctr-P fzf ignores
let g:ctrlp_custom_ignore = {'dir': '\.git$\'}

" Enable powerline fonts for airline status line
let g:airline_powerline_fonts = 1
