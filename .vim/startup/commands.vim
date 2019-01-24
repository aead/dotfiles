
" Show QuickFix window after grep commands
autocmd QuickFixCmdPost *grep* cwindow

" Enable spell checking for git commit messages
autocmd FileType gitcommit setlocal spell
