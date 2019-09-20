alias up='sudo snap refresh && sudo apt update && sudo apt upgrade'
alias xopen='xdg-open'
alias cat='bat'
alias ls='exa'
alias ll='exa -hHl -L 1 --tree --group-directories-first'
alias grep='rg'
alias ff='git status --porcelain | awk '"'"'{print $2}'"'"' | fzf --sync --exit-0 --height 100% --reverse --border --preview-window=right:75% --preview '"'"'git diff "$PWD/"{} | bat --color always'"'"' 1> /dev/null'
#alias ff='git status --porcelain | awk '"'"'{print $2}'"'"' | fzf --sync --height 100% --reverse --border --preview-window=right:75% --preview '"'"'bat --color always "$PWD/"{}'"'"' 1> /dev/null'

