" Map <leader> key to ','
let mapleader = ","

" Map double <leader> to escape
nnoremap <leader>, <Esc>
vnoremap <leader>, <Esc>
inoremap <leader>, <Esc>
cnoremap <leader>, <Esc>

nnoremap <CR> A<CR>

" Backspace in normal should work like in insert mode.
nnoremap <BS> i<BS>

" Close window in normal mode with q and close-without-saving with Q.
nnoremap q :q<CR>
nnoremap Q :q!<CR>

" Close another opened window in normal, visual and insert mode
" with Ctrl+q 
nnoremap <C-q> <C-w>w:q<CR>
vnoremap <C-q> <Esc><C-w>w:q<CR>
inoremap <C-q> <C-O><C-w>w<C-O>:q<CR>

" Ctrl-S saves files (requires stty -ixon)
nnoremap <silent> <C-S> :update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>

" Make <Enter> on popup menu work as expected.
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Always select entry in popup menu and adjust search.
inoremap <expr> <C-n> pumvisible() ? '<C-n>' : \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" Use Shift-[Up/Down] to navigate to the next text object.
nnoremap <S-Up> {
inoremap <S-Up> <C-O>{
nnoremap <S-Down> }
inoremap <S-Down> <C-O>}

" Use Ctrl-w Ctrl-w to create new tab.
nnoremap <C-w><C-w> :tabnew<CR>
inoremap <C-w><C-w> <C-O>:tabnew<CR>

" Use Ctrl-w t to move a split view to a new tab.
nnoremap <C-w>t <C-w>T
inoremap <C-w>t <C-O><C-w>T

" Use Ctrl-Shift-[Left/Right] to navigate to the previous/next tab.
nnoremap <C-S-Left>  :tabprevious<CR>
inoremap <C-S-Left>  <C-O>:tabprevious<CR>
nnoremap <C-S-Right> :tabNext<CR>
inoremap <C-S-Right>  <C-O>:tabNext<CR>

" Use Ctrl-[Up/Down/Left/Right] to navigate to the window to the
" top/bottom/left/right.
nnoremap <C-Up>    <C-w><Up>
inoremap <C-Up>    <C-O><C-w><Up>
nnoremap <C-Down>  <C-w><Down>
inoremap <C-Down>  <C-O><C-w><Down>
nnoremap <C-Left>  <C-w><Left>
inoremap <C-Left>  <C-O><C-w><Left>
nnoremap <C-Right> <C-w><Right>
inoremap <C-Right> <C-O><C-w><Right>

" Split windows
" nnoremap <C-w>V :vne<CR>
" inoremap <C-w>V <C-O>:vne<CR>
" nnoremap <C-w>S :new<CR>
" inoremap <C-w>S <C-O>:new<CR>

" Cycle through quickfix window entries
nnoremap <F8> :cprevious<CR>
nnoremap <F9> :cnext<CR>
inoremap <F8> <C-O>:cprevious<CR>
inoremap <F9> <C-O>:cnext<CR>

" Switch color schemes
nnoremap <F3> :colorscheme vscode<CR>
nnoremap <F4> :colorscheme github<CR>

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
