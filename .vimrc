set runtimepath^=~/.vim/bundle/ctrlp.vim
set runtimepath^=~/.vim/bundle/fugitive.vim
set runtimepath^=~/.vim/bundle/airline.vim
set runtimepath^=~/.vim/bundle/airline-themes.vim
set runtimepath^=~/.vim/bundle/nerdtree.vim

" Enable syntax highlighting 
syntax on
filetype plugin indent on

" Map ö to escape in insert mode 
noremap  ö <Esc>
vnoremap ö <Esc>
inoremap ö <Esc> 

" Map ü to :q to exit windows faster
noremap  ü :q<CR>
vnoremap ü :q<CR>
inoremap ü :q<CR> 

" Map Ctrl-Space as autocomplete
inoremap <Nul> <C-n> 

" Enable powerline fonts for airline status line
let g:airline_powerline_fonts = 1

" Enable spell checking
autocmd BufRead,BufNewFile .txt *.md setlocal spell
autocmd FileType gitcommit setlocal spell

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
