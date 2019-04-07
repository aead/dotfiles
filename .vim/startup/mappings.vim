" Map <leader> key to ','
let mapleader = ","

" Map double <leader> to escape
nnoremap <leader>, <Esc>
vnoremap <leader>, <Esc>
inoremap <leader>, <Esc>
cnoremap <leader>, <Esc>

" Enter in normal mode goes to the end of the line,
" switch to insert mode and insert enter (newline).
nnoremap <CR> A<CR>

" Backspace in normal mode switches to insert mode
" and insert a backspac (delete last char)
nnoremap <BS> i<BS>

" Close windows using ö/Ö 
nnoremap <C-q> :q<CR>
vnoremap <C-q> <Esc>:q<CR>
inoremap <C-q> <C-O>:q<CR>
nnoremap <C-x> <C-w>w:q<CR>
vnoremap <C-x> <Esc><C-w>w:q<CR>
inoremap <C-x> <C-O><C-w>w<C-O>:q<CR>

" Ctrl-S saves files (requires stty -ixon)
noremap <silent> <C-S>  :update<CR>i
vnoremap <silent> <C-S> <Esc>:update<CR><Esc>
inoremap <silent> <C-S> <C-O>:update<CR><Esc>

" Make <Enter> on popup menu work as expected.
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Always select entry in popup menu and adjust search.
inoremap <expr> <C-n> pumvisible() ? '<C-n>' : 
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" Switch faster between windows
nnoremap <C-Up>    <C-w><Up>
inoremap <C-Up>    <C-O><C-w><Up>
nnoremap <C-Down>  <C-w><Down>
inoremap <C-Down>  <C-O><C-w><Down>
nnoremap <C-Left>  <C-w><Left>
inoremap <C-Left>  <C-O><C-w><Left>
nnoremap <C-Right> <C-w><Right>
inoremap <C-Right> <C-O><C-w><Right>

" Split windows
nnoremap <leader>< :vsplit<CR>
inoremap <leader>< <C-O>:vsplit<CR>
nnoremap <leader>- :split<CR>
inoremap <leader>- <C-O>:split<CR>

" Cycle through Location/QuickFix window entries
nnoremap ü :cprevious<CR>
nnoremap Ü :lprevious<CR>
nnoremap ä :cnext<CR>
nnoremap Ä :lnext<CR>

" Git shortcuts
nnoremap gl :Glog<CR><CR>
" Hint: use o to open Gblame entry commit in new window
nnoremap gb :Gblame<CR>
nnoremap gd :Gvdiff<CR>
nnoremap gD :Gdiff<CR>
nnoremap gc :Gcommit<CR>
nnoremap ga :Gcommit --amend --no-edit<CR><CR>
nnoremap gp :Gpull --rebase
nnoremap gP :Gpush
nnoremap gf :Gfetch<CR>
nnoremap gs :Gstatus<CR>
