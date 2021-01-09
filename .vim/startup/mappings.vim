" Enter, space and backspace should behave consistent in
" normal and insert mode:
nnoremap <CR> A<CR>
nnoremap <Space> i<Space>
nnoremap <BS> i<BS>

" Ctrl-i triggers auto-completion. (keyword completion)
" Unfortunately, vim treats TAB as Ctrl-i. Therefore,
" we have to re.map Ctrl-i. Otherwise, TAB would not
" behave as expected.
inoremap <C-i> <C-x><C-n>

" Enter in visual mode copies the selection to clipboard
vnoremap <CR> y<Esc> 

" Make <Enter> on popup menu work as expected.
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Always select entry in popup menu and adjust search.
inoremap <expr> <C-n> pumvisible() ? '<C-n>' : \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" Ctrl-w-Ctrl-w switch windows (like in normal mode)
inoremap <C-W><C-W> <C-O><C-W><C-W>
vnoremap <C-W><C-W> <C-O><C-W><C-W>

" Ctrl-Space keeps only the current window open
" and closes all others.
nnoremap <Nul> :only<CR>
inoremap <Nul> <C-O>:only<CR>
vnoremap <Nul> <C-O>:only<CR>

" Ctrl-s saves files (requires stty -ixon)
nnoremap <silent> <C-S> :update<CR>
vnoremap <silent> <C-S> <C-O>:update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>
cnoremap <silent> <C-S> <C-O>:update<CR>

" F12 opens a new terminal in vim on the right
nnoremap <F12> :vertical botright terminal<CR> 
vnoremap <F12> <C-O>:vertical botright terminal<CR> 
inoremap <F12> <C-O>:vertical botright terminal<CR> 
cnoremap <F12> <C-O>:vertical botright terminal<CR> 

" Ctrl-d close current window
nnoremap <C-d> :q<CR>
vnoremap <C-d> <C-O>:q<CR>
inoremap <C-d> <C-O>:q<CR>
cnoremap <C-d> <C-O>:q<CR>

" Ctrl-a selects the current line
nnoremap <C-a> V
inoremap <C-a> <C-O>V

"+------------------------------+
"| Scrolling & Text navigation  |
"+------------------------------+

" Alt-Up scrolls up
nnoremap <M-Up> <C-y>
inoremap <M-Up> <C-O><C-y>
vnoremap <M-Up> <C-O><C-y>
cnoremap <M-Up> <C-O><C-y>

" Alt-Down scrolls down
nnoremap <M-Down> <C-e>
inoremap <M-Down> <C-O><C-e>
vnoremap <M-Down> <C-O><C-e>
cnoremap <M-Down> <C-O><C-e>

" Ctrl-Up jump to the previous paragraph
nnoremap <C-Up> {
inoremap <C-Up> <C-O>{
vnoremap <C-Up> {

" Ctrl-Down jump to next paragraph
nnoremap <C-Down> }
inoremap <C-Down> <C-O>}
vnoremap <C-Down> }

"+------------------------------+
"| Quickfix window              |
"+------------------------------+

" Ctrl-PageUp select previous entry in the quickfix window
nnoremap <C-PageUp> :cprevious<CR>
inoremap <C-PageUp> <C-O>:cprevious<CR>

" Ctrl-PageDown select next entry in the quickfix window
nnoremap <C-PageDown> :cnext<CR>
inoremap <C-PageDown> <C-O>:cnext<CR>

"+------------------------------+
"| Searching                    |
"+------------------------------+

" Ctrl-f fuzzy-search file content
nnoremap <C-f> :BLines<CR>
inoremap <C-f> <C-O>:BLines<CR>

" Ctrl-p fuzzy-search files (root is $PWD) and open it in current
" window
"
" During fuzzy-search Ctrl-a toogles a preview, Ctrl-x opens
" the selected file on the right and Ctrl-y opens the selected
" file in a split window.
nnoremap <C-p> :FZF<CR>
vnoremap <C-p> <C-O>:FZF<CR>
inoremap <C-p> <C-O>:FZF<CR>
cnoremap <C-p> <C-O>:FZF<CR>

" AltGr-p fuzzy-search files (root is $HOME) and open it in current
" window
"
" During fuzzy-search Ctrl-a toogles a preview, Ctrl-x opens
" the selected file on the right and Ctrl-y opens the selected
" file in a split window.
nnoremap þ :Files $HOME<CR>
vnoremap þ <C-O>:Files $HOME<CR>
inoremap þ <C-O>:Files $HOME<CR>
cnoremap þ <C-O>:Files $HOME<CR>

"+------------------------------+
"| Git shortcuts                |
"+------------------------------+

" Ctrl-x-Ctrl-s show git diff in vsplit window
nnoremap <C-x><C-s> :Gvdiff<CR>
inoremap <C-x><C-s> <C-O>:Gvdiff<CR>

" Ctrl-x-Ctrl-d list changed files (git status)
nnoremap <C-x><C-d> :GFiles?<CR>
inoremap <C-x><C-d> <C-O>:GFiles?<CR>

" Ctrl-x-Ctrl-b show git blame of current window
nnoremap <C-x><C-b> :Gblame<CR>
inoremap <C-x><C-b> <C-O>:Gblame<CR>
