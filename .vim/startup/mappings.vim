" Enter, space and backspace should behave consistent in
" normal and insert mode:
nnoremap <CR> A<CR>
nnoremap <Space> i<Space>
nnoremap <BS> i<BS>

" Ctrl-i triggers auto-completion. (keyword completion)
" Unfortunately, vim treats TAB as Ctrl-i. Therefore,
" we have to remap Ctrl-i. Otherwise, TAB would not
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
inoremap <C-d> <C-O>:q<CR>
vnoremap <C-d> <C-O>:q<CR>
cnoremap <C-D> <C-O>:q<CR>

" Opt-W closes all windows, except the currently selected one. 
nnoremap ∑ :only<CR>
vnoremap ∑ <C-O>:only<CR>
inoremap ∑ <C-O>:only<CR>

" Ctrl-a selects the current line
nnoremap <C-a> V
inoremap <C-a> <C-O>V

" Ctrl-v switch to visual mode
nnoremap <C-v> v
inoremap <C-v> <C-O>v

"+------------------------------+
"| Scrolling & Text navigation  |
"+------------------------------+

" The Mac Terminal may not send the key correct escape codes
" such that Vim may not recognize key combinations like <C-Down>.
" Therefore, the following escape code mappings have to be configured:
" <S-up>:      \033[1;2A
" <S-down>:    \033[1;2B
" <S-right>:   \033[1;2C
" <S-left>:    \033[1;2D
"
" <M-up>:      \033[1;3A
" <M-down>:    \033[1;3B
" <M-right>:   \033[1;3C
" <M-left>:    \033[1;3D
"
" <M-S-up>:    \033[1;4A
" <M-S-down>:  \033[1;4B
" <M-S-right>: \033[1;4C
" <M-S-left>:  \033[1;4D
"
" <C-up>:      \033[1;5A
" <C-down>:    \033[1;5B
" <C-right>:   \033[1;5C
" <C-left>:    \033[1;5D


" Shift-Up jump to the previous paragraph
nnoremap <S-Up> {
inoremap <S-Up> <C-O>{
vnoremap <S-Up> {

" Shift-Down jump to next paragraph
nnoremap <S-Down> }
inoremap <S-Down> <C-O>}
vnoremap <S-Down> }

"+------------------------------+
"| Quickfix window              |
"+------------------------------+

" Ctrl-PageUp select previous entry in the quickfix window
nnoremap <M-Up> :cprevious<CR>
inoremap <M-up> <C-O>:cprevious<CR>

" Ctrl-PageDown select next entry in the quickfix window
nnoremap <M-Down> :cnext<CR>
inoremap <M-Down> <C-O>:cnext<CR>

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

" S-Opt-P fuzzy-search files (root is $HOME) and open it in current
" window
"
" During fuzzy-search Ctrl-a toogles a preview, Ctrl-x opens
" the selected file on the right and Ctrl-y opens the selected
" file in a split window.
nnoremap <C-π> :Files $HOME<CR>
vnoremap <C-π> <C-O>:Files $HOME<CR>
inoremap <C-π> <C-O>:Files $HOME<CR>
cnoremap <C-π> <C-O>:Files $HOME<CR>

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
