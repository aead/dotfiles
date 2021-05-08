PATH="$HOME/go/bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
PATH="/opt/homebrew/bin:$PATH"

PATH="/opt/homebrew/opt/openssl@1.1/bin:$PATH"
PATH="/opt/homebrew/opt/curl/bin:$PATH"

# Disable Ctrl-S for terminal output halt -> in vim Ctrl-S saves file
stty -ixon

# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
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
alias light-mode='export BAT_THEME=GitHub && export VIM_COLOR=Github'
alias dark-mode='unset BAT_THEME && unset VIM_COLOR'

#
# Shell functions
#

export FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden'
export FZF_DEFAULT_OPTS="--bind 'change:top,page-up:preview-page-up,page-down:preview-page-down,CTRL-W:toggle-preview-wrap,ctrl-A:toggle-preview' --preview-window hidden --preview ' [[ -f {} ]] && bat -n --color=always {}'"

# vim-fzf starts a file search and opens the selected file in vim.
vim-fzf() {
  local file
  file=$(rg --files --follow --no-ignore-vcs --hidden | fzf \
         --exit-0 \
         --reverse \
         --cycle \
         --height 50% \
         --preview-window='right:60%:nohidden' \
         --preview='head -n 300 | bat -n --color=always {}'
        )
  [ -n "$file" ] && ${EDITOR:-vim} --not-a-term "$file"
  zle reset-prompt
}

zle -N vim-fzf
bindkey '^P' vim-fzf

# fd-fzf starts a directory search and cd's into the selected directory.
#
# It uses fd to walk find all directories under the current one ($PWD)
# and shows a preview of the directory. If the directory is a git repository
# fd-fzf shows the commit message of the first commit and a list of the
# subsequent commits. Otherwise, fd-fzf lists the directory using exa.
#
# If the current directory does not have sub-directories fd-fzf does nothing.
fd-fzf() {
   local dir
   dir=$(fd --follow --type d -F "" \
         | fzf \
           --exit-0 \
           --reverse \
           --cycle \
           --height 100% \
           --preview-window='right:50%' \
           --preview='[[ $(isgit {}) != "" ]] && git -C {} log -n 1 --color=always && echo "" && git -C {} log --color=always --pretty=format:"%C(auto) %h %Creset %cs  %s" --skip=1 || exa -hHl -L 1 --tree --color always --group-directories-first {}'
         ) && cd "$dir"
   zle reset-prompt
}

# ff fuzzy-search all files interactively that contain search string.
ff() {
   local file init_cmd
   if [ ! "$#" -gt 0 ]; then
      init_cmd="true"
   else
      init_cmd="rg --hidden --follow --files-with-matches --no-messages -F $1"
   fi
   file=$($init_cmd | \
          fzf \
          --query="$1" \
          --phony \
          --reverse \
          --cycle \
          --height 100% \
          --bind='change:reload([[ -n {q} ]] && rg --hidden --follow --files-with-matches --no-messages -F {q} || true)+top' \
          --preview-window='right:60%:nohidden' \
          --preview '[[ -f {} ]] && rg --ignore-case --pretty --context 10 -F {q} {} | bat --style=snip --color always'
         )
    [[ -n "$file" ]] && ${EDITOR:-vim} --not-a-term "$file"
    zle reset-prompt
}

zle -N ff
bindkey "^F" "ff"

# cd behaves like the bash builtin cd command when an directory is
# specified and opens an inline fzf directory search otherwise.
#
# The fzf instance shows all first-level sub-directories.
# With → (right-arrow) the fzf switches into the selected
# sub-direcory S and reloads the selection area with the
# sub-directories of S.

# The fzf walks one directory-level backwards when the ← (left-arrow)
# is encountered.

# The ALT-d key restarts the fzf instance from the top-level
# directory.
function cd() {
    if [[ "$#" != 0 ]]; then
        builtin cd "$@";
        return
    fi
    local dir=$(fd --maxdepth=1 --type d --hidden | fzf \
                --reverse \
                --tac \
                --cycle \
                --height 40% \
                --bind='ALT-D:reload(fd --maxdepth=1 --type d --hidden)' \
                --bind='right:reload(fd --maxdepth=1 --type d --hidden "." {})' \
                --bind='left:reload(dirname {} | xargs -r dirname | xargs -r fd --maxdepth=1 --type d --hidden ".")' \
                --preview-window='right:65%:hidden' \
                --preview 'exa -hHla -L 1 --color=always --group-directories-first {}'
               )
    [[ ${#dir} != 0 ]] || return 0
    cd "$dir"
}

# fd-git behaves like fd-fzf but filters for directories that are git
# repositories. Since it only searches for git repositories fd-git
# always shows the commit message of the first commit and a list of
# the subsequent commits as preview.
fd-git() {
   local dir
   dir=$(fd --follow --type d "." "$HOME" | isgit | sort \
         | fzf \
           --exit-0 \
           --reverse \
           --cycle \
           --height 40% \
           --preview-window='right:60%' \
           --preview 'git -C {} log -n 1 --color=always && echo "" && git -C {} log --color=always --pretty=format:"%C(auto) %h %Creset %cs  %s" --skip=1'
         ) && cd "$dir"
   zle reset-prompt
}

zle -N fd-git fd-git
bindkey '^S' fd-git

# git-diff
#   - Requires that $PWD is a git repo.
#
# It fuzzy-searches all changed files and
# displays a preview of the diff (compared
# to HEAD) of the currently selected file.
#
# If a file has been selected git-diff opens
# it in vim.
git-diff() {
    local f=$(git ls-files \
                -m -o \
                --exclude-standard \
              | fzf \
                --sync \
                --exit-0 \
                --reverse \
                --border \
                --sort \
                --preview-window=top:80%:nohidden \
                --preview 'git diff -s --exit-code {}; [[ $? == 1 ]] && git diff {} | delta --width=$FZF_PREVIEW_COLUMNS || bat --color always {}')
    [[ -n "$f" ]] && ${EDITOR:-vim} --not-a-term "$f"
    zle reset-prompt
}

zle -N git-diff git-diff
bindkey '^X' git-diff

git-branch() {
  local result=$(git branch --color=always \
                 | rg -v '/HEAD\s' \
                 | fzf \
                   --reverse \
                   --height 50% \
                   --border \
                   --ansi \
                   --tac \
                   --preview-window right:70% \
                   --preview 'git show -p --color=always "$(sed s/^..// <<< {} | cut -d" " -f1)" | bat' \
                 | sed 's/^..//' | cut -d' ' -f1
                )
  if [[ $result != "" ]]; then
      git checkout "$result"
  fi
  zle reset-prompt
}

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
