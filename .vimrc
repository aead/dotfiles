set runtimepath^=~/.vim/bundle/ctrlp.vim
set runtimepath^=~/.vim/bundle/fugitive.vim

" Enable syntax highlighting 
syntax on
filetype plugin indent on

" Default color scheme
" colorscheme monokai

" Set line numbers
set number
set ruler
set cursorline

" Disable Backup and Swap files
set noswapfile
set nobackup
set nowritebackup

" Ctrl-S saves files
noremap <silent> <C-S>  :update<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>

" Always show the status bar
set laststatus=2

" Automatically open the QuickFix window after grep/Glog/...
autocmd QuickFixCmdPost *grep* cwindow
" map gl to Glog + <Enter> to skip git log terminal output  
nmap gl :Glog<CR><CR>

" Map Ctrl+W + <Arrow> to Ctrl+<Arrow> for switching windows faster 
nnoremap <C-Up> <C-w><Up>
nnoremap <C-Down> <C-w><Down>
nnoremap <C-Left> <C-w><Left>
nnoremap <C-Right> <C-w><Right>

" Ctr-P fzf ignores
let g:ctrlp_custom_ignore = {'dir': '\.git$\'}

" Tab settings for Go
au FileType go set noexpandtab tabstop=4 shiftwidth=4

" Use goreturns for Go code formating
let g:go_fmt_command = "goreturns"
