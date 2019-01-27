" Map <leader> key to ','
let mapleader = ","

" Map double <leader> to escape
nnoremap <leader>, <Esc>
vnoremap <leader>, <Esc>
inoremap <leader>, <Esc>
cnoremap <leader>, <Esc>

" Close windows using ö/Ö 
nnoremap ö :q<CR>
vnoremap ö <Esc>:q<CR>
inoremap ö <C-O>:q<CR>
nnoremap Ö <C-w>w:q<CR>
vnoremap Ö <Esc><C-w>w:q<CR>
inoremap Ö <C-O><C-w>w<C-O>:q<CR>

" Ctrl-S saves files (requires stty -ixon)
noremap <silent> <C-S>  :update<CR>
vnoremap <silent> <C-S> <Esc>:update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>

" Map TAB and ß as autocomplete                                                           
inoremap <tab> <C-X><C-O>
inoremap ß <C-n>

" Map qq to TAB for ident in insert mode
inoremap qq <tab>

" Switch faster between windows
nnoremap <C-Up>    <C-w><Up>
inoremap <C-Up>    <C-O><C-w><Up>
nnoremap <C-Down>  <C-w><Down>
inoremap <C-Down>  <C-O><C-w><Down>
nnoremap <C-Left>  <C-w><Left>
inoremap <C-Left>  <C-O><C-w><Left>
nnoremap <C-Right> <C-w><Right>
inoremap <C-Right> <C-O><C-w><Right>

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
