# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    #function git_branch {
    #  local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null);
    #  if [[ -n $branch ]];then
    #    local repo_path=$(git rev-parse --absolute-git-dir 2> /dev/null);
    #    local repo_status=$(git status --short --show-stash --ignore-submodules=untracked 2> /dev/null);
    #    if [[ -n $repo_status && $repo_path != "$HOME/.git" ]];then
    #        echo " ($branch) ✘";
    #    elif [[ $repo_path != "$HOME/.git" ]];then
    #       echo " ($branch)";
	#elif [[ -n $repo_status && $repo_path = "$HOME/.git" ]];then
    #       echo " ✘";
	#fi
    #  fi	
    #}
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[1;36m\]\A \W/\[\033[1;31m\]$(git_branch)\[\033[1;36m\] ➜\[\033[00m\] '
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Use starship prompt - requires cargo install cargo install starship
eval "$(starship init bash)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# disable ctrl-S for terminal output halt -> in vim ctrl-S saves file 
stty -ixon

# Set Vim colorscheme based on day time.
currenttime=$(date +%H:%M)
if [[ "$currenttime" > "08:30" ]] && [[ "$currenttime" < "18:30" ]]; then
    export VIM_COLOR=vscode
else
    export VIM_COLOR=vscode
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden'
export FZF_DEFAULT_OPTS="--bind 'page-up:preview-page-up,page-down:preview-page-down,ctrl-w:beginning-of-line+kill-line,ctrl-A:toggle-preview' --preview-window hidden --preview ' [[ -f {} ]] && bat -n --color=always {}'"

# Commands and functions for a great CLI experience
#

# Command: v [arg-1]
# Fuzzy search for a file - if 1st arg is non-empty use it as search query.
# If there is only one, open it directly. If there is no match exit. Otherwise,
# list matches and the first 200 lines of text files as preview on the right.
v() {
  local file
  file=($(fzf --query="$1" --select-1 --exit-0 --height 100% --reverse --border --bind='CTRL-A:toggle-preview' --preview-window right:50% --preview 'head -n 200 | bat -n --color=always {}'))
  [[ -n "$file" ]] && ${EDITOR:-vim} "$file"
}

# Command: c [arg-1]
# Fuzzy search for a directory - if 1st arg is non-empty use it as search query.
# If there is only one, cd into it directly. If there is no match exit. Otherwise,
# list files and directories within the currently selected one on the right.
c() {
    local dir
    dir=$(fd -HL -t d "." "$HOME" \
          | fzf --query="$1" --select-1 --exit-0 --height 100% --reverse --border --bind='CTRL-A:toggle-preview' --preview-window right:50%  --preview 'exa -hHl -L 1 --tree --color always --group-directories-first {}') && cd "$dir" && v
}

# Command: sf [arg-1]
# Fuzzy search for [arg-1] matches in files and show matching content as preview on 
# the right. If 1st arg is empty read it from STDIN.
sf() {
  local file query
  if [ ! "$#" -gt 0 ]; then 
      read -p '(search:) ' query
  else
      query="$1"
  fi
  if [ -z "$query" ]; then 
      echo "Error: Search query required" >&2;
      return 1; 
  fi

  file=$(rg --files-with-matches --no-messages "$query" \
         | fzf --exit-0 --height 100% --reverse --border --bind='CTRL-A:toggle-preview' --preview-window=right:75% --preview "rg --ignore-case --pretty --context 10 '$query' {} | bat --style=snip --color always")
  [[ -n "$file" ]] && ${EDITOR:-vim} "$file"
}

export MANPAGER="bat -p -l man"

fman() {
   local m=$(man -k . \
             | fzf \
               --query="$1" \
               --exit-0 \
               --exact \
               --reverse \
               --border \
               --bind='CTRL-A:toggle-preview' \
               --preview-window=right:60% \
               --preview 'man {1}'
            )
   [[ -n "$m" ]] && echo "$m" | awk '{print $1}' | xargs -r man
}

# Command: goDecl [arg-1]
# Parse all func and type definitions in:
#  - go file if arg-1 is a go file
#  - all go files (non-recursive) if arg-1 is a directory
#  - all go files recursivly if arg-1 is omitted
# and fuzzy search the go identifiers. 
# It opens the file which contains the selected identifier
# at the correct position.
go-decl() {
    get-decl() {
        if [ "$1" == "" ]; then
            "$1" == "."
        fi
        if [[ -d "$1" ]]; then
           echo $(motion -dir "$1" -mode decls -include func,type -format json 2> /dev/null)
        else 
           echo $(motion -file "$1" -mode decls -include func,type -format json 2> /dev/null)
        fi
    }

    file=$(get-decl "$1" \
           | jq \
             -r '.decls | .[] | "\( .keyword ) \( .ident ) \( .filename) \( .line ) \( .col )"' \
             2> /dev/null \
           | fzf \
             --exit-0 \
             --select-1 \
             --reverse \
             --with-nth 1,2 \
             --height=50% \
             --preview-window top:5% \
             --bind='CTRL-A:toggle-preview' \
             --preview 'bat --color always -n -r {4}:{4} {3}' \
           | awk '{print "+"$4 " " $3}'
          )
    [[ -n "$file" ]] && ${EDITOR:-vim} $(echo "$file")
}

# Command: goList [arg-1]
# Fuzzy search all go packages in GOPATH and GOROOT
# if arg-1 is empty. Otherwise, fuzzy search all
# packages in GOPATH and GOROOT that start with arg-1.
# While fuzzy searching list all files in the currently
# selected package.
# Once a package is selected then fuzzy search the package
# files (recursivly) and show currently selected file as
# preview.
# Finally, open selected file in vim.
goList() {
    local arg dir file goMod
    if [ "$1" == "" ]; then
        arg="all"
    else
        arg="$1"
    fi
    
    goMod="$GO111MODULE"
    GO111MODULE="off"
    dir=$(go list -f '{{ .ImportPath }} {{ .Dir }}' "$arg" \
          | fzf --exit-0 --height 100% --with-nth 1 --reverse --border --bind='CTRL-A:toggle-preview' \
          --preview-window=right:50% --preview 'exa -hHl -L 1 --group-directories-first --tree --color always {2}' \
          | awk '{print $2}')
    if [[ -n "$dir" ]]; then
        file=($(fd . "$dir" --type f -exec echo {/} | fzf --select-1 --exit-0 --height 100% --reverse --border --bind='CTRL-A:toggle-preview' --preview "bat -n --color=always $dir/{}"))
        [[ -n "$file" ]] && ${EDITOR:-vim} $(echo "$dir/$file")
    fi 
    GO111MODULE="$goMod"
}

# git-show [query]
#   - Requires that $PWD is a git repo.
# 
# It fuzzy-searches 'git log' and displays the 
# 'git show' of the currently selected commit.
# 
# If a commit has been selected and STDOUT is 
# not a TTY git-show outputs the (short) commit
# ID.
git-show() {
    local c=$(git log \
                --format='%C(auto)%h%d %s %C(white)%C(bold)%cr' \
                --color=always \
              | fzf \
                --query="$1" \
                --exit-0 \
                --ansi \
                --reverse \
                --exact \
                --border \
                --no-sort \
                --bind='CTRL-A:toggle-preview' \
                --preview-window=right:50% \
                --preview 'git show --name-status --color=always {1} | bat -n --color always'
            )
    [[ -n "$c" ]] && [[ ! -t 1 ]] && echo "$c" | awk '{print $1}'
}

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
                --bind='CTRL-A:toggle-preview' \
                --preview-window=right:75% \
                --preview '[[ -n $(git diff --name-only {}) ]] && git diff -U10 {} | bat -n --color always || bat -n --color always {}')
    [[ -n "$f" ]] && ${EDITOR:-vim} $(echo "$f")
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
    local f=$(git ls-files \
              | fzf \
                --query="$1" \
                --exit-0 \
                --reverse \
                --border \
                --sort \
                --bind='CTRL-A:toggle-preview' \
                --preview-window=right:50% \
                --preview 'git blame --root -s --color-by-age --color-lines {} | sed -r "s/(\s+)?\S+//2"  | bat -n --color always'
            )
    if [ -n "$f" ]; then
        local c=$(git log \
                    --format='%C(auto)%h%d %s %C(white)%C(bold)%cr' \
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
                    --bind='CTRL-A:toggle-preview' \
                    --preview-window=right:50% \
                    --preview 'git show -p --color=always {1} | bat -n --color always'
                 )
       [[ -n "$c" ]] && echo "$c" | awk '{print $1}' 
    fi
}

# Command: gitDiff
# Requires that $PWD is a git repo.
# Fuzzy search all commits and show commit
# message of currently selected file in
# preview. 
# Once a commit is selected it shows the
# diff (like gitDiff command) of the commit
# compared to master.
gitReview() {
  local commit parent file
  commit=$(git log --pretty=format:"%h  %<(23)%aN %s" \
          | fzf --query="$1" --sort --exit-0 --reverse --exact --bind='CTRL-A:toggle-preview' \
          --preview-window right:40% --preview 'git show -s $(echo {} | awk '"'"'{print $1}'"'"') | bat -n --color always') &&

  commit=$(echo "$commit" | awk '{print $1}') &&
  parent=$(git log --pretty="%p" -n 1 "$commit") &&
  
  file=$(git diff "$parent" "$commit" --name-only \
         | fzf --sync --exit-0 --height 100% --reverse --border --bind='CTRL-A:toggle-preview' \
         --preview-window=right:75% --preview "git diff -U10 '$parent' '$commit' {} | bat -n --color always")
  
  if [ -n "$file" ]; then 
       ${EDITOR:-vim} $(echo "$file")
  fi
}

pr() {
  local pr branch
  if [ ! "$#" -gt 0 ]; then 
      read -p '(PR id:) ' pr
  else
      pr="$1"
  fi
  if [ -z "$pr" ]; then 
      echo "Error: Missing pull request ID" >&2;
      return 1; 
  fi
  branch="review_pr_$pr" &&
  git fetch origin "pull/$pr/head:$branch"
  if [ $? -eq 0 ]; then
    git diff "master..$branch" --name-only | fzf --sync --exit-0 --height 100% --reverse --border --preview-window=right:75% --preview "git diff -U10 master.."$branch" {} | bat -n --color always"
    git branch -D "$branch"
  fi
}

pr-review() {
   local re url user repo pulls pr branch base dir
   re="^(https|git)(:\/\/|@)([^\/:]+)[\/:]([^\/:]+)\/(.+).git$"
   if [ "$1" != "" ]; then
       base=$1
   else
       base="master" 
   fi
   if [ "$2" != "" ]; then
       url=$2
   else
      url=$(git config --get remote.origin.url)
   fi
   if [[ $url =~ $re ]]; then    
      user=${BASH_REMATCH[4]}
      repo=${BASH_REMATCH[5]}
      if [ "$2" != "" ]; then
         dir=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1) &&
         mkdir "$dir" && git clone "$url" "./$dir/$repo" && cd "$dir/$repo"
      fi
 
      pulls=$(curl -X GET "https://api.github.com/repos/$user/$repo/pulls?state=open" 2> /dev/null | jq -r '.[] | "\( .number ), \( .user.login ), \( .title )"' | awk -v FS="," '{printf "%s %-15s %s\n",$1,$2,$3}') && 
      #pr=$(echo "$pulls" | fzf --sync --reverse --border --preview 'curl -X GET "https://api.github.com/repos/'$user'/'$repo'/pulls/$(echo {} | awk '"'"'{print $1}'"'"')" 2> /dev/null | jq . | bat -n --color always' | awk '{print $1}')
      pr=$(echo "$pulls" | fzf --sync --exact --exit-0 --reverse | awk '{print $1}')
      if [ -n "$pr" ]; then 
         branch="review_pr_$pr" &&
         git fetch origin "pull/$pr/head:$branch"
         if [ $? -eq 0 ]; then
            git diff "$base...$branch" --name-only | fzf --sync --exit-0 --height 100% --reverse --border --preview-window=right:75% --preview "git diff -U10 "$base...$branch" {} | bat -n --color always"
            git branch -D "$branch"
         fi
      fi
      if [ "$dir" != "" ]; then
         read -p "Remove $dir/$repo  [N/y]? " -n 1 -r
         if [[ $REPLY =~ ^[Yy]$ ]]; then
             cd "../.."
             rm -rf "$dir" 
         fi
        echo "" 
      fi
      echo ""
      echo "Github pull request URL:"
      echo ""
      echo "  - PR  : https://github.com/$user/$repo/pull/$pr"
      echo "  - Diff: https://github.com/$user/$repo/pull/$pr/files"
      echo ""
   fi
}

bind -x '"\C-p": "v"'
bind -x '"\C-s": "c"'

bind -x '"\C-x\C-s": "git-show"'
bind -x '"\C-x\C-d": "git-diff"'
bind -x '"\C-x\C-b": "git-blame"'
bind -x '"\C-xr": "gitReview"'

bind -x '"\C-gd": "go-decl ."'
bind -x '"\C-gl": "goList all"'

complete -C /home/andreas/go/bin/mc mc

