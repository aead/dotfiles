set runtimepath^=~/.vim/bundle/ctrlp.vim
set runtimepath^=~/.vim/bundle/fugitive.vim
set runtimepath^=~/.vim/bundle/airline.vim
set runtimepath^=~/.vim/bundle/airline-themes.vim
set runtimepath^=~/.vim/bundle/nerdtree.vim
set runtimepath^=~/.vim/bundle/latex-preview.vim

" Enable syntax highlighting 
syntax on
filetype plugin on 
filetype indent on

source ~/.vim/startup/settings.vim
source ~/.vim/startup/mappings.vim
source ~/.vim/startup/commands.vim

" Default color scheme
" colorscheme monokai

"Map NerdTree command to Ctrl-b
nnoremap <C-b> :NERDTree<CR>
