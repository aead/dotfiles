" Go-specific settings

au FileType go set noexpandtab
let g:go_fmt_command = "goimports"
let g:go_test_timeout = "1m"
let g:go_def_mode = "gopls"
let g:go_info_mode = "gopls"

setlocal splitright
setlocal omnifunc=go#complete#Complete
" let b:vcm_tab_complete = "omni"

" Go-specific key mappings

" Jump back after go-to-definition
nnoremap <leader>l :GoDefPop<CR>
inoremap <leader>l <C-O>:GoDefPop<CR>

" Jump to prev entry in the quickfix window
nnoremap <leader>m :cprev<CR>
inoremap <leader>m <C-O>:cprev<CR>

" Jump to next entry in the quickfix window
nnoremap <leader>. :cnext<CR>
inoremap <leader>. <C-O>:cnext<CR>

" Executes 'go build' async
nnoremap <leader>b :GoBuild<CR>
inoremap <leader>b <C-O>:GoBuild<CR>

" Rename identifier under cursor
nnoremap <leader>r :GoRename<CR>
inoremap <leader>r <Esc>:GoRename<CR>

"Executes 'go test' async
nnoremap <leader>t :GoTest<CR>
inoremap <leader>t <C-O>:GoTest<CR>

"Jump to the definition of whatever is under the cursor 
nnoremap <leader>j :GoDef<CR>
inoremap <leader>j <C-O>:GoDef<CR>

"Split window vertically and jump to the definition of whatever is under the cursor
nnoremap <leader>k :vsplit<CR>:GoDef<CR>
inoremap <leader>k <C-O>:vsplit<CR><C-O>:GoDef<CR>

"Open docs for whatever is under the cursor
nnoremap <leader>h :GoDoc<CR>
inoremap <leader>h <C-O>:GoDoc<CR>

"Open 'godoc.org' docs of whatever is under the cursor
nnoremap <leader>H :GoDocBrowser<CR>
inoremap <leader>H <C-O>:GoDocBrowser<CR>

 "Show file-level declarations (functions, types, a.s.o)
nnoremap <leader>f :GoDecls<CR>
inoremap <leader>f <C-O>:GoDecls<CR>

 "Show package-level declarations (functions, types, a.s.o)
nnoremap <leader>d :GoDeclsDir<CR>
inoremap <leader>d <C-O>:GoDeclsDir<CR>

" Switch between .go and _test.go file
nnoremap <leader>a :GoAlternate<CR>
nnoremap <leader>A <C-w>v<C-w>w:GoAlternate<CR>
inoremap <leader>A <C-O><C-w>v<C-O><C-w>w<C-O>:GoAlternate<CR>

