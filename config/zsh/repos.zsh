# vim: set ft=zsh ts=2 sw=2 et :

function list-repos {
  {
    if (( $+commands[ghqrs] )); then
      ghqrs list
    elif (( $+commands[ghq] )); then
      ghq list -p
    fi
    ls -1 -d --color=none "$HOME/.vim/plugged/"*
    echo "$HOME/.dotfiles"
  } \
  | sed "s#^$HOME#~#g"
}


function git-check-health {
  local repo_dir=$(echo ${1:-$(pwd)} | sed -e "s|~|$HOME|g")
  pushd $repo_dir > /dev/null

  # dirty status
  [[ $(git diff --shortstat 2>/dev/null | tail -n1) != "" ]] && echo -n "*" || echo -n " "

  # untracked files
  expr $(git status --porcelain 2>/dev/null | grep "^??" | wc -l)

  popd > /dev/null
}


function list-sick-repos {
  local __dirty=()
  local __untracked=()

  list-repos | while read line; do
    local st=$(git-check-health $line)
    if [[ ${st:0:1} = "*" ]]; then
      __dirty+=($line)
    elif (( ${st:1:1} > 0 )); then
      __untracked+=($line)
    fi
  done

  if (( $#__dirty > 0 )); then
    echo -e '\033[1;31mDirty repositories:\033[0m'
    for repo in $__dirty; do
      echo " $repo"
    done
    echo
  fi

  if (( $#__untracked > 0 )); then
    echo -e '\033[1;34mRepositories which has untracked files:\033[0m'
    for repo in $__untracked; do
      echo " $repo"
    done
  fi

  [[ "$#__dirty" -eq 0 ]] && [[ "$#__untracked" -eq 0 ]]
}
