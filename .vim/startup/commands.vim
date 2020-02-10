
" Show QuickFix window after grep commands
autocmd QuickFixCmdPost *grep* cwindow

" Enable spell checking for git commit messages
autocmd FileType gitcommit setlocal spell

" Customize the fzf BLines command (options)
command! -bang -nargs=* BLines call fzf#vim#buffer_lines(<q-args>, {'options': ['--exact', '--cycle']}, <bang>0)

