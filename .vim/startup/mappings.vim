" Map <leader> key to ','
let mapleader = ","

" Map double <leader> to escape
nnoremap <leader>, <Esc>
vnoremap <leader>, <Esc>
inoremap <leader>, <Esc>
cnoremap <leader>, <Esc>

" FZF key binding
nnoremap <C-p> :FZF<CR>
vnoremap <C-p> <C-O>:FZF<CR>
inoremap <C-p> <C-O>>:FZF<CR>
cnoremap <C-p> <C-O>:FZF<CR>

" Enter inserts new-line below the current line.
nnoremap <CR> A<CR>

" Backspace and Space in normal should work like in insert mode.
nnoremap <BS> i<BS>
nnoremap <Space> i<Space>

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
vnoremap <S-Up> {
nnoremap <S-Down> }
inoremap <S-Down> <C-O>}
vnoremap <S-Down> }

" Cycle through tabs with Ctrl-^
nnoremap <Nul>      :tabnext<CR>
inoremap <Nul>      <C-O>:tabnext<CR>

" Use 2x Ctrl-w to move current window to tab
nnoremap <C-w><C-w> <C-w>T
inoremap <C-w><C-w> <C-O><C-w>T

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

" Reopen recently closed window.
nnoremap <C-l> :e #<CR>
inoremap <C-l> <C-O>:e #<CR>
nnoremap <C-w>ls :split#<CR>
inoremap <C-w>ls <C-O>:split#<CR>
nnoremap <C-w>lv :vsplit#<CR>
inoremap <C-w>lv <C-O>:vsplit#<CR>

" Fuzzy search files with preview
" on the right and open selected
" in a right split view.
nnoremap <silent> <leader>p :call fzf#run({ 'right': winwidth('.') / 2, 'sink': 'vertical botright split', 'options': '-1 --reverse --preview-window top:75% --bind="CTRL-A:toggle-preview" --preview "bat --color always -n {}"' })<CR>
inoremap <silent> <leader>p <C-O>:call fzf#run({ 'right': winwidth('.') / 2, 'sink': 'vertical botright split', 'options': '-1 --reverse --preview-window top:75% --bind="CTRL-A:toggle-preview" --preview "bat --color always -n {}"' })<CR>

" Fuzzy search file content
nnoremap <C-f> :BLines<CR>
inoremap <C-f> <C-O>:BLines<CR>

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
nnoremap <C-x><C-d> :Gvdiff<CR>
inoremap <C-x><C-d> <C-O>:Gvdiff<CR>

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
nnoremap go :Git co 
