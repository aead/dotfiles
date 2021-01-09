au FileType go set noexpandtab

let g:go_fmt_command = "goimports"
let g:go_test_timeout = "1m"
let g:go_def_mode = "gopls"
let g:go_info_mode = "gopls"
let g:go_gorename_command = 'gopls'

setlocal splitright
setlocal omnifunc=go#complete#Complete

" .<Space> trigger auto-completion.
inoremap .<Space> .<C-x><C-o>

" Ctrl-i triggers auto-completion. (omni-complete)
" Unfortunately, vim treats TAB as Ctrl-i. Therefore,
" we have to re.map Ctrl-i. Otherwise, TAB would not
" behave as expected.
inoremap <C-i> <C-x><C-o>

" Ctrl-b triggers a go build of current file / package
nnoremap <C-b> :GoBuild<CR>
inoremap <C-b> <C-O>:GoBuild<CR>

" Ctrl-j jumps to the definition of selected type / identifier
nnoremap <C-j> :GoDef<CR>
inoremap <C-j> <C-O>:GoDef<CR>

" Ctrl-k jumps to the definition of selected type / identifier
" but open it in a window on the right
nnoremap <C-k> :vsplit<CR>:GoDef<CR>
inoremap <C-k> <C-O>:vsplit<CR><C-O>:GoDef<CR>

" Ctrl-o jumps back after jumping to a definition
nnoremap <C-o> :GoDefPop<CR>
inoremap <C-o> <C-O>:GoDefPop<CR>

" Ctrl-l list type / function declartions in the current file
nnoremap <C-l> :GoDecls<CR>
inoremap <C-l> <C-O>:GoDecls<CR>


