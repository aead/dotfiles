set nocompatible

" Show shortcut commands in status line
set showcmd

" Show line numbers
set number

" Show ruler {line, column, virt. column} number
set ruler

" Show cursor line
set cursorline

" Don't auto. wrap lines 
set nowrap

" Convert tabs to spaces
set expandtab

" Set the terminal window title
set title

" Insert 4 spaces for one tab
set tabstop=4

" Insert 4 spaces for indentation
set shiftwidth=4

" Disable swap and backup files
set noswapfile
set nobackup
set nowritebackup

" Set encoding to UTF-8
set enc=utf-8

" Enable incremental search (search while typing)
set incsearch

" Show command completion options
set wildmenu

" Don't show menu detail
set completeopt=longest,menuone

" Reload buffer if underlying file has changed
set autoread

" Use the system clipboard for copy/paste (requries vim-gtk3 package).
set clipboard^=unnamed,unnamedplus

" Enable spell checking for git commit messages and markdown
autocmd FileType gitcommit setlocal spell
autocmd FileType markdown setlocal spell

" Use 256 color support of terminal.
let &t_Co=256

let g:fzf_action = { 'ctrl-t': 'tab split', 'ctrl-y': 'split', 'ctrl-x': 'vertical botright split' }

" StatusLine customization
set laststatus=2
set statusline=
set statusline+=%1*\ %{GitInfo()}                        " Git Branch name
set statusline+=%1*\ %<%f\%{ReadOnly()}                  " File path
set statusline+=%1*\ %m\ %w                              " File modifier
set statusline+=%1#warningmsg#
set statusline+=%1{SyntasticStatuslineFlag()}            " Syntastic errors
set statusline+=%1*\ %=                                  " Space
set statusline+=%1*\ %y\                                 " FileType
set statusline+=%1*\ %{(&fenc!=''?&fenc:&enc)}\          " Encoding
set statusline+=%1*\ %-3(%{FileSize()}%)                 " File size
set statusline+=%1*\ %2p%%\                              " Rownumber/total (%)

" Change color of the mode message 
highlight ModeMsg  term=standout ctermfg=75 ctermbg=234 guifg=#569CD6 guibg=#1E1E1E
" Change color of current line number
highlight CursorLineNr term=bold ctermfg=75 ctermbg=234 guifg=#BBBBBB guibg=#1E1E1E

" Syntastic settings
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Command :Shell (args) runs an arbitrary shell command
" and writes the output to a vertical buffer on the right.
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline) abort
    exe 'vertical botright terminal '. a:cmdline
endfunction

" ------
" Helper functions for the status line

function! FileSize()
  let bytes = getfsize(expand('%:p'))
  if (bytes >= 1024)
    let kbytes = bytes / 1024
  endif
  if (exists('kbytes') && kbytes >= 1000)
    let mbytes = kbytes / 1000
  endif
  if bytes <= 0
    return '0'
  endif
  if (exists('mbytes'))
    return mbytes . 'MB '
  elseif (exists('kbytes'))
    return kbytes . 'KB '
  else
    return bytes . 'B '
  endif
endfunction

function! ReadOnly()
  if &readonly || !&modifiable
    return ''
  else
    return ''
endfunction

function! GitInfo()
  let head = fugitive#head()
  if head != ''
    return ' ('.head.')'
  else
    return ' '
endfunction
