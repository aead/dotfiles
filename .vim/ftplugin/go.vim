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

nnoremap <leader>b :GoBuild<CR>
inoremap <leader>b <C-O>:GoBuild<CR>

nnoremap <leader>t :GoTest<CR>
inoremap <leader>t <C-O>:GoTest<CR>

nnoremap <leader>i :GoDef<CR>
inoremap <leader>i <C-O>:GoDef<CR>
nnoremap <leader>j :vsplit<CR>:GoDef<CR>
inoremap <leader>j <C-O>:vsplit<CR><C-O>:GoDef<CR>

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

nnoremap <leader>I :GoSameIdsToggle<CR>
inoremap <leader>I <C-O>:GoSameIdsToggle<CR>

nnoremap <leader>v :GoInfo<CR>
inoremap <leader>v <C-O>:GoInfo<CR>

nnoremap <leader>e :GoIfErr<CR>
inoremap <leader>e <C-O>:GoIfErr<CR>
