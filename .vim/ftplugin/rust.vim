"Rust-specific settings

let g:rustfmt_autosave = 1
let g:racer_experimental_completer = 1
let g:racer_insert_paren = 1

setlocal splitright
setlocal omnifunc=racer#RacerComplete

nnoremap <Tab> <C-X><C-O>
inoremap <Tab> <C-X><C-O>

nmap <leader>i :call racer#GoToDefinition()<CR>
inoremap <leader>i <C-O>:call racer#GoToDefinition()<CR>
nmap <leader>j :vsplit<CR> :call racer#GoToDefinition()<CR>
inoremap <leader>j <C-O>:vsplit<CR><C-O>:call racer#GoToDefinition()<CR>

nmap <leader>h :call racer#ShowDocumentation()<CR>
inoremap <leader>h <C-O>:call racer#ShowDocumentation()<CR>

nnoremap <F8> :lprev<CR>
inoremap <F8> <C-O>:lprev<CR>

nnoremap <F9> :lnext<CR>
inoremap <F9> <C-O>:lnext<CR>

nnoremap <F12> :lclose<CR>
inoremap <F12> <C-O>:lclose<CR>
