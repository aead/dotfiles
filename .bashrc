# ~/.bashrc: executed by bash(0) for non-login shells.
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

# 
if [ -f ~/.bash_tools ]; then
    . ~/.bash_tools
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

# disable ctrl-Q for resuming terminal output -> in vim ctrl-Q closes windows
stty start undef

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

vim-git() {
   local file
   file=$(fd -HL -t f "." $(fd -L -t d "." -X isgit | xargs) \
          | fzf --exit-0 --height 100% --reverse --border \
            --bind='CTRL-A:toggle-preview' --preview-window right:60% \
            --preview 'bat -n --color always {}'
         )
   [[ -n "$file" ]] && ${EDITOR:-vim} "$file"
}

export MANPAGER='sh -c "col -bx | bat -l man -n"'

man-fzf() {
   local m=$(man -k . \
             | fzf \
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
                --format='%C(auto)%h%C(reset) %cs %s' \
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
                --preview 'git show --stat --color=always {1} | bat -n --color always'
            )
    [[ -n "$c" ]] && echo "$c" | awk '{print $1}' | 2c && echo "Copied $(c2) to clipboard!"
    return 0;
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
                --preview 'git diff -s --exit-code {}; [[ $? == 1 ]] && bat --diff --diff-context 8 --color always {} || bat --color always {}')
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
    local f=$(git ls-files | fzf \
                --query="$1" \
                --exit-0 \
                --reverse \
                --border \
                --sort \
                --bind='CTRL-A:toggle-preview' \
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
                    --bind='CTRL-A:toggle-preview' \
                    --preview-window=right:50% \
                    --preview 'git show --stat -p --color=always {1}'
                 )
       [[ -n "$c" ]] && echo "$c" | awk '{print $1}' | 2c && echo "Copied $(c2) to clipboard!" 
    fi
}

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
}

# Command: git-review
# Requires that $PWD is a git repo.
# Fuzzy search all commits and show commit
# message of currently selected file in
# preview. 
# Once a commit is selected it shows the
# diff of the commit compared to master.
git-review() {
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

# export VIM_COLOR=github 
# export BAT_THEME=GitHub 

complete -C /home/andreas/go/bin/mc mc
