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

function! SmartTabComplete()
  let line = getline('.')
  let substr = strpart(line, -1, col('.')+1)      " from the start of the current
                                                  " line to one character right
                                                  " of the cursor
  let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
  if (strlen(substr)==0)                          " nothing to match on empty string
    return "\<tab>"
  endif

  let has_period = match(substr, '\.') != -1      " position of period, if any
  let has_slash = match(substr, '\/') != -1       " position of slash, if any
  let has_colon = match(substr, '\:') != -1
  if (!has_period && !has_slash && !has_colon)
    return "\<C-X>\<C-P>"                         " existing text matching
  elseif ( has_slash )
    return "\<C-X>\<C-F>"                         " file matching
  else
    return "\<C-X>\<C-O>"                         " plugin matching
  endif
endfunction

" Map tab to autocomplete in insert and normal mode.
inoremap <tab> <c-r>=SmartTabComplete()<CR>
nnoremap <tab> i<tab>

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
