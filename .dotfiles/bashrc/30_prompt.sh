#!/usr/bin/env bash

# https://gist.github.com/michaelneu/943693f46f7aa249fad2e6841cd918d5
COLOR_RESET='\[\033[0m\]'
COLOR_GIT_CLEAN='\[\033[0;32m\]'    # green
COLOR_GIT_MODIFIED='\[\033[0;31m\]' # red
COLOR_GIT_STAGED='\[\033[0;33m\]'   # yellow

function git_prompt() {
  if [ -e ".git" ]; then
    branch_name=$(git symbolic-ref -q HEAD)
    branch_name=${branch_name##refs/heads/}
    branch_name=${branch_name:-HEAD}

    echo -n "→ "

    if [[ $(git status 2> /dev/null | tail -n1) = *"nothing to commit"* ]]; then
      echo -n "$COLOR_GIT_CLEAN$branch_name$COLOR_RESET"
    elif [[ $(git status 2> /dev/null | head -n5) = *"Changes to be committed"* ]]; then
      echo -n "$COLOR_GIT_STAGED$branch_name$COLOR_RESET"
    else
      echo -n "$COLOR_GIT_MODIFIED$branch_name*$COLOR_RESET"
    fi

    echo -n " "
  fi
}

function prompt() {
  PS1="\u@\h [ \w $(git_prompt)] \$ "
}

PROMPT_COMMAND="history -a; history -c; history -r; prompt"














