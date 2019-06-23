"Rust-specific settings

let g:rustfmt_autosave = 1
let g:racer_experimental_completer = 1
let g:racer_insert_paren = 1

setlocal splitright
setlocal omnifunc=racer#RacerComplete

nnoremap <Tab> <C-X><C-O>
inoremap <Tab> <C-X><C-O>

nnoremap <leader>m :lprev<CR>
inoremap <leader>m <C-O>:lprev<CR>

nnoremap <leader>. :lnext<CR>
inoremap <leader>. <C-O>:lnext<CR>


" Jump back if we've jumped to a definition
nnoremap <leader>o <C-o>
inoremap <leader>o <C-O><C-o>

" Jump to prev entry in location list
nnoremap <leader>m :lprev<CR>
inoremap <leader>m <C-O>:lprev<CR>

" Jump to next entry in location list
nnoremap <leader>. :lnext<CR>
inoremap <leader>. <C-O>:lnext<CR>

" Executes 'cargo build'
nnoremap <leader>b :!cargo build<CR>
inoremap <leader>b <C-O>:!cargo build<CR>

" Executes 'cargo test' and show output in new window
nnoremap <leader>t :call rust#Test(1, '')<CR>
inoremap <leader>t <C-O>:call rust#test(1, '')<CR>

" Jump to the definition of whatever is under the cursor
nnoremap <leader>j :call racer#GoToDefinition()<CR>
inoremap <leader>j <C-O>:call racer#GoToDefinition()<CR>

" Split window vertically and jump to the definition of whatever is under the cursor
nnoremap <leader>J :vsplit<CR>:call racer#GoToDefinition()<CR>
inoremap <leader>J <C-O>:vsplit<CR><C-O>:call racer#GoToDefinition()<CR>

" Open docs for whatever is under the cursor
nmap <leader>h :call racer#ShowDocumentation()<CR>
inoremap <leader>h <C-O>:call racer#ShowDocumentation()<CR>


