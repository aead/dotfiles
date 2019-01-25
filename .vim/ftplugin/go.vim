" Go-specific settings
 
au FileType go set noexpandtab
let g:go_fmt_command = "goreturns"
let g:go_test_timeout = "1m"

" Go-specific key mappings

" Map TAB as autocomplete                                                                  
inoremap <tab> <C-n>

nnoremap <leader>b :GoBuild<CR>
inoremap <leader>b <C-O>:GoBuild<CR>
nnoremap <leader>B :GoTestCompile<CR>
inoremap <leader>B <C-O>:GoTestCompile<CR>

nnoremap <leader>t :GoTest<CR>
inoremap <leader>t <C-O>:GoTest<CR>
nnoremap <leader>T :GoTest -run=
inoremap <leader>T <Esc>:GoTest -run=

nnoremap <leader>j :GoDef<CR>
inoremap <leader>j <C-O>:GoDef<CR>

nnoremap <leader>d :GoDecls<CR>
vnoremap <leader>d <Esc>:GoDecls<CR>
inoremap <leader>d <Esc>:GoDecls<CR>

nnoremap <leader>D :GoDeclsDir<CR>
inoremap <leader>D <Esc>:GoDeclsDir<CR>
vnoremap <leader>D <Esc>:GoDeclsDir<CR>

nnoremap <leader>h :GoDoc<CR>
inoremap <leader>h <C-O>:GoDoc<CR>
nnoremap <leader>H :GoDocBrowser<CR>
inoremap <leader>H <C-O>:GoDocBrowser<CR>

nnoremap <leader>a :GoAlternate<CR>
nnoremap <leader>A <C-w>v<C-w>w:GoAlternate<CR>
inoremap <leader>A <C-O><C-w>v<C-O><C-w>w<C-O>:GoAlternate<CR>

nnoremap <leader>l :GoReferrers<CR>
inoremap <leader>l <Esc>:GoReferrers<CR>

nnoremap <leader>r :GoRename<CR>
inoremap <leader>r <Esc>:GoRename<CR>

nnoremap <leader>i :GoInfo<CR>
inoremap <leader>i <C-O>:GoInfo<CR>

nnoremap <leader>I :GoSameIdsToggle<CR>
inoremap <leader>I <C-O>:GoSameIdsToggle<CR>

nnoremap <leader>e :GoIfErr<CR>
inoremap <leader>e <C-O>:GoIfErr<CR>
