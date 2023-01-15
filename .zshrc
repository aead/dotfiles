PATH="$HOME/go/bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
PATH="/opt/homebrew/bin:$PATH"

PATH="/opt/homebrew/opt/openssl@1.1/bin:$PATH"
PATH="/opt/homebrew/opt/curl/bin:$PATH"

# Disable Ctrl-S for terminal output halt -> in vim Ctrl-S saves file
stty -ixon

# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY # Append to history and 
setopt HIST_FIND_NO_DUPS  # Ignore dublicate history entries (Up Arrow)
setopt HIST_IGNORE_DUPS   # Don't add consecutive duplicates entries  

# Delete .zsh_sessions on startup
if [ -d ~/.zsh_sessions ]; then
   rm -rf ~/.zsh_sessions
fi

# Add FZF functions and shortcuts
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Enable command completion (e.g. git)
autoload -Uz compinit && compinit

# Customize zsh prompt using starship
eval "$(starship init zsh)"

# Alias definitions
alias cat='bat'
alias ls='exa'
alias ll='exa -hHl -L 1 --tree --group-directories-first'
alias grep='rg'
# alias 2c='xclip -selection c'
# alias c2='xclip -selection c -o'
alias light-mode='export BAT_THEME=GitHub'
alias dark-mode='unset BAT_THEME'

# Replace non-breaking spaces (Option + Space) with a regular space.
# This avoids "command not found" issues when using pipes - e.g. ls | cat.
bindkey -s '\xC2\xA0' ' '

#
# Shell functions
#

switch-theme() {
   if [ -v VIM_COLOR ]; then
      unset BAT_THEME && unset VIM_COLOR
  else
      export BAT_THEME=GitHub && export VIM_COLOR=Github
   fi
}   
zle -N switch-theme
bindkey '⁄' switch-theme # Opt+I

export FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden'
export FZF_DEFAULT_OPTS="--bind 'change:top,page-up:preview-page-up,page-down:preview-page-down,CTRL-W:toggle-preview-wrap,ctrl-A:toggle-preview' --layout reverse --preview-window noborder --preview ' [[ -f {} ]] && bat -n --color=always {}'"

function __fzf-edit {
  local file=$(rg --files --follow --no-ignore-vcs --hidden | fzf \
         --exit-0 \
         --reverse \
         --cycle \
         --info inline \
         --margin 5% \
         --height 100% \
         --border sharp \
         --preview-window='right:50%:nohidden,border-left' \
         --preview='head -n 300 | bat -n --color=always {}'
        )
  [[ -n "$file" ]] && BUFFER="hx $file $BUFFER" && zle accept-line "$@"
  zle reset-prompt
}
zle -N __fzf-edit
bindkey '^p' __fzf-edit

function __fzf-search {
   local file
   file=$(rg --files --follow --no-ignore-vcs --hidden | \
          fzf \
          --phony \
          --reverse \
          --cycle \
          --info inline \
          --margin 5% \
          --height 100% \
          --border sharp \
          --bind='change:reload([[ -n {q} ]] && rg --hidden --follow --files-with-matches --no-messages -F {q} || rg --files --follow --no-ignore-vcs --hidden)+top' \
          --preview-window='right:50%:nohidden,border-left' \
          --preview '[[ -f {} ]] && rg --ignore-case --pretty --context 10 -F {q} {} | bat --style=snip --color always'
         )
  [[ -n "$file" ]] && BUFFER="hx $file $BUFFER" && zle accept-line "$@"
  zle reset-prompt
}
zle -N __fzf-search
bindkey '^f' __fzf-search

function __fzf-git-files {
  local file
  file=$(git ls-files \
         -m -o \
         --exclude-standard \
         | fzf \
         --exit-0 \
         --reverse \
         --sort \
         --cycle \
         --margin 5% \
         --height 100% \
         --border sharp \
         --preview-window='right:50%:nohidden,border-left' \
         --preview 'bat -n --color always {}')
  [[ -n "$file" ]] && BUFFER="hx $file $BUFFER" && zle accept-line "$@"
  zle reset-prompt
}
zle -N __fzf-git-files
bindkey '^g' __fzf-git-files

function __fzf-git-diff() {
    local file=$(git ls-files \
                -m -o \
                --exclude-standard \
              | fzf \
                --exit-0 \
                --reverse \
                --sort \
                --cycle \
                --info inline \
                --margin 5% \
                --height 100% \
                --border sharp \
                --preview-window='bottom:95%:nohidden,border-top' \
                --preview 'git diff -s --exit-code {}; [[ $? == 1 ]] && git diff {} | delta --width=$FZF_PREVIEW_COLUMNS || bat --color always {}')
    [[ -n "$file" ]] && BUFFER="hx $file $BUFFER" && zle accept-line "$@"
    zle reset-prompt
}
zle -N __fzf-git-diff
bindkey '^X' __fzf-git-diff

__fzf-git-branch() {
  local branch=$(git branch --color=always \
                 | rg -v '/HEAD\s' \
                 | fzf \
                   --exit-0 \
                   --reverse \
                   --sort \
                   --ansi \
                   --tac \
                   --multi \
                   --margin 5% \
                   --height 100% \
                   --border sharp \
                   --preview-window='right:50%:nohidden,border-left' \
                   --preview 'git show -p --color=always "$(sed s/^..// <<< {} | cut -d" " -f1)" | bat' \
                 | sed 's/^..//' | cut -d ' ' -f1
                )
  if [[ $branch != "" ]]; then
      branch=$(echo "$branch" | tr '\n' ' ')
      BUFFER="$BUFFER $branch"
  fi
  zle reset-prompt
}
zle -N __fzf-git-branch
bindkey '^b' __fzf-git-branch

function __fzf-cd-git() {
   local dir
   dir=$(fd --follow --type d "." "$HOME" | isgit | sort \
         | fzf \
           --exit-0 \
           --reverse \
           --sort \
           --cycle \
           --margin 5% \
           --height 100% \
           --border sharp \
           --preview-window='right:50%:nohidden,border-left' \
           --preview 'git -C {} log -n 1 --color=always && echo "" && git -C {} log --color=always --pretty=format:"%C(auto) %h %Creset %cs  %s" --skip=1'
         ) && cd "$dir"
   zle reset-prompt
}
zle -N __fzf-cd-git
bindkey '^S' __fzf-cd-git


# git-blame [query]
#   - Requires that $PWD is a git repo.
#
# It fuzzy-searches 'git ls-files' and displays
# the 'git blame' of the currently selected file.
#
# If a file has been selected git-blame fuzzy-
# searches all commits that modified that file
# (using 'git log') and displays the commit as
# patch in the preview.
#
# If a commit has been selected git-blame prints
# that commit to STDOUT.
git-blame() {
    local f=$(git ls-files | fzf \
                --query="$1" \
                --exit-0 \
                --reverse \
                --border \
                --sort \
                --preview-window=right:50% \
                --preview 'paste -d " " <(git blame -s --color-by-age --color-lines {} | cut -d " " -f1) <(bat --color=always --decorations=never {}) | bat -n --color=always'
            )
    if [ -n "$f" ]; then
        local c=$(git log \
                    --format='%C(auto)%h %cs %s' \
                    --color=always \
                    -- "$f" \
                  | fzf \
                    --query="$1" \
                    --exit-0 \
                    --ansi \
                    --reverse \
                    --exact \
                    --border \
                    --no-sort \
                    --preview-window=right:50% \
                    --preview 'git show --stat -p --color=always {1}'
                 )
       [[ -n "$c" ]] && echo "$c" | awk '{print $1}' | 2c && echo "Copied $(c2) to clipboard!"
    fi
    zle reset-prompt
}
