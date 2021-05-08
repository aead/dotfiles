"Rust-specific settings

let g:rustfmt_autosave = 1
let g:racer_experimental_completer = 1
let g:racer_insert_paren = 1

setlocal splitright
setlocal omnifunc=racer#RacerComplete

" .<Space> and ::<Space> trigger auto-completion.
inoremap .<Space> .<C-x><C-o>

" Ctrl-i triggers auto-completion. (omni-complete)
" Unfortunately, vim treats TAB as Ctrl-i. Therefore,
" we have to remap Ctrl-i. Otherwise, TAB would not
" behave as expected.
inoremap <C-i> <C-x><C-o>

" Executes 'cargo build'
nnoremap <C-b> :Cbuild<CR>
inoremap <C-b> <C-O>:Cbuild<CR>

" Jump to the definition of whatever is under the cursor
nnoremap <C-j> :call racer#GoToDefinition()<CR>
inoremap <C-j> <C-O>:call racer#GoToDefinition()<CR>

" Split window vertically and jump to the definition of whatever is under the cursor
nnoremap <C-k> :vsplit<CR>:call racer#GoToDefinition()<CR>
inoremap <C-k> <C-O>:vsplit<CR><C-O>:call racer#GoToDefinition()<CR>

" Ctrl-PageUp select previous entry in the location list window
nnoremap <M-Up> :lprevious<CR>
inoremap <M-up> <C-O>:lprevious<CR>

" Ctrl-PageDown select next entry in the location list window
nnoremap <M-Down> :lnext<CR>
inoremap <M-Down> <C-O>:lnext<CR>

