set runtimepath^=~/.vim/bundle/fugitive.vim
"set runtimepath^=~/.vim/bundle/latex-preview.vim
set runtimepath^=~/.vim/bundle/racer.vim
set runtimepath^=~/.vim/bundle/syntastic.vim
set runtimepath^=~/.vim/bundle/fzf.vim
set runtimepath^=~/.fzf

" Enable syntax highlighting 
syntax on
filetype plugin on 
filetype indent on

" Default color scheme
if !empty($VIM_COLOR)
    colorscheme $VIM_COLOR
else
    colorscheme vscode
endif

source ~/.vim/startup/settings.vim
source ~/.vim/startup/mappings.vim
source ~/.vim/startup/commands.vim
