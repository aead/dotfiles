" Go-specific settings

au FileType go set noexpandtab
let g:go_fmt_command = "goreturns"
let g:go_test_timeout = "1m"
let g:go_def_mode = "gopls"
let g:go_info_mode = 'guru'

setlocal splitright
setlocal omnifunc=go#complete#Complete
" let b:vcm_tab_complete = "omni"

" Go-specific key mappings

" Jump back if we've jumped to a definition
nnoremap <leader>o <C-o>
inoremap <leader>o <C-O><C-o>

" Jump to prev entry in the quickfix window
nnoremap <leader>m :cprev<CR>
inoremap <leader>m <C-O>:cprev<CR>

" Jump to next entry in the quickfix window
nnoremap <leader>. :cnext<CR>
inoremap <leader>. <C-O>:cnext<CR>

" Executes 'go build' async
nnoremap <leader>b :GoBuild<CR>
inoremap <leader>b <C-O>:GoBuild<CR>

"Executes 'go test' async
nnoremap <leader>t :GoTest<CR>
inoremap <leader>t <C-O>:GoTest<CR>

"Jump to the definition of whatever is under the cursor 
nnoremap <leader>j :GoDef<CR>
inoremap <leader>j <C-O>:GoDef<CR>

"Split window vertically and jump to the definition of whatever is under the cursor
nnoremap <leader>J :vsplit<CR>:GoDef<CR>
inoremap <leader>J <C-O>:vsplit<CR><C-O>:GoDef<CR>

"Open docs for whatever is under the cursor
nnoremap <leader>h :GoDoc<CR>
inoremap <leader>h <C-O>:GoDoc<CR>

"Open 'godoc.org' docs of whatever is under the cursor
nnoremap <leader>H :GoDocBrowser<CR>
inoremap <leader>H <C-O>:GoDocBrowser<CR>

"Show package-level declarations (functions, types, a.s.o)
nnoremap <leader>d :GoDeclsDir<CR>
inoremap <leader>d <C-O>:GoDeclsDir<CR>

nnoremap <leader>a :GoAlternate<CR>
nnoremap <leader>A <C-w>v<C-w>w:GoAlternate<CR>
inoremap <leader>A <C-O><C-w>v<C-O><C-w>w<C-O>:GoAlternate<CR>

nnoremap <leader>l :GoReferrers<CR>
inoremap <leader>l <Esc>:GoReferrers<CR>

nnoremap <leader>r :GoRename<CR>
inoremap <leader>r <Esc>:GoRename<CR>

nnoremap <leader>I :GoSameIdsToggle<CR>
inoremap <leader>I <C-O>:GoSameIdsToggle<CR>

