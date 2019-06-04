"Rust-specific settings

let g:rustfmt_autosave = 1
let g:racer_experimental_completer = 1
let g:racer_insert_paren = 1

setlocal splitright
setlocal omnifunc=racer#RacerComplete

nnoremap <Tab> <C-X><C-O>
inoremap <Tab> <C-X><C-O>

nmap <leader>j :call racer#GoToDefinition()<CR>
inoremap <leader>j <C-O>:vsplit<CR><C-O>:call racer#GoToDefinition()<CR>
nmap <leader>d :call racer#ShowDocumentation()<CR>
inoremap <leader>d <C-O>:call racer#ShowDocumentation()<CR>
