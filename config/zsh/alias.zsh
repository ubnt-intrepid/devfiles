# vim: set ft=zsh ts=2 sw=2 et :

function open {
  case ${OSTYPE} in
    linux*)
      local _open=xdg-open
      local _path="echo -n"
      ;;
    cygwin|msys*)
      local _open=explorer
      local _path="cygpath -w"
      ;;
  esac
  local arg=${1:-"$(pwd)"}

  $_open "$(eval "$_path $arg")"
}

function tmux {
  if [[ -n $VIRTUAL_ENV ]]; then
    echo "${fg[red]}Before execute tmux, deactive current virtualenv.${reset_color}"
    return 1
  fi
  $commands[tmux] "$@"
}

function ls {
  # if the argument is a single file or stdin is pipe
  if [[ ($# -eq 1 && -f "$1") || (-p /dev/stdin) ]]; then
    ${PAGER:-less} "$@"
  else
    $commands[ls] -F --color --show-control-chars -I 'ntuser.ini' -I 'NTUSER.DAT*' -I 'ntuser.dat*' "$@"
  fi
}

function path {
  for p in $path; do
    echo $p
  done
}

function fpath {
  for p in $fpath; do
    echo $p
  done
}

alias q=exit
alias c=clear
alias g=git
alias e="\$EDITOR"
alias o=open
alias l=ls
alias L='ls -a'


if (( $+commands[wslbridge] )); then
  alias wslbridge="$commands[wslbridge] -C '~'"
fi

if [[ -f "/c/Windows/System32/lxrun.exe" ]]; then
  function lxrun {
    local arg
    for arg in "$@"; do
      if [[ ${arg[1]} = "-" ]]; then
        arg="${arg/-///}"
      fi
      set -- "$@" "$arg"
      shift
    done
    OPTIND=1
    winpty "/c/Windows/System32/lxrun.exe" "$@"
  }
fi

if (( $+commands[vagrant] )); then
  (( $+commands[winpty] )) || alias vagrant='winpty vagrant'
fi


function __fuzzy_select {
  local func="${1}"
  local prompt="${2:-QUERY}> "
  local after="${3}"

  if (( $+commands[fzy] )); then
    local __select=fzy
  elif (( $+commands[fzf] )); then
    local __select=fzf
  else
    return
  fi
  local selected=$(eval "${func}" | eval "${__select} --prompt='${prompt}' --query='$LBUFFER'")
  if [[ -n $selected ]]; then
    if [[ -n ${after} ]]; then
      BUFFER=$(eval "echo ${after}")
    else
      BUFFER="${selected}"
    fi
    zle accept-line
  fi
  zle clear-screen
}

function __fuzzy-select-repositories {
  __fuzzy_select "list-repos" "REPOS" 'cd $selected'
}

function __fuzzy-select-history {
  __fuzzy_select "history -n 1 | tac" "HISTORY"
}

zle -N __fuzzy-select-repositories
zle -N __fuzzy-select-history

bindkey '^g' __fuzzy-select-repositories
bindkey '^r' __fuzzy-select-history
