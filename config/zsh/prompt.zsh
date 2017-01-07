# vim: set ft=zsh ts=2 sw=2 et :

autoload -U add-zsh-hook

setopt prompt_subst

### Fish style pwd (prompt_pwd)
function prompt_pwd() {
  case $OSTYPE in
    *msys*)
      local PERL=/usr/bin/perl
      ;;
    *)
      local PERL=perl
      ;;
  esac
  echo $(pwd | $PERL -pe '
   BEGIN {
      binmode STDIN,  ":encoding(UTF-8)";
      binmode STDOUT, ":encoding(UTF-8)";
   };
   s|^$ENV{HOME}|~|g;
   s|/([^/.])[^/]*(?=/)|/$1|g;
   s|/\.([^/])[^/]*(?=/)|/.$1|g;
  ')
}


### current VCS's information
function __get_vcs_info {
  if [[ -z $vcs_info_msg_0_ ]]; then
    (( $+commands[vcs_info] )) || return
    vcs_info_msg_0_="$(vcs_info 2>/dev/null)"
  fi
  echo "$vcs_info_msg_0_"
}

function __clear_vcs_info {
  [[ -z $vcs_info_msg_0_ ]] || unset vcs_info_msg_0
}

add-zsh-hook precmd __clear_vcs_info


### current environment information
__env_info_list=()


function __env_info_rust {
  (( $+commands[rustup] )) || return

  rustup show | grep 'override' > /dev/null
  (( $? )) && return  # skip if current toolchain is not overrided

  basename $(rustc --print sysroot) | cut -d '-' -f 1
}

function __env_info_python {
  if [[ "${CONDA_DEFAULT_ENV}" == "root" ]]; then
    local _env="miniconda"
  elif [[ -n "${CONDA_DEFAULT_ENV}" ]]; then
    local _env="miniconda,${CONDA_DEFAULT_ENV}"
  elif [[ -n "$VIRTUAL_ENV" ]]; then
    local _env="$(basename $VIRTUAL_ENV)"
  else
    return
  fi
  echo "${_env}"
}

function __env_info_ruby {
  (( $+commands[ruby] )) || return
  ruby --version 2>&1 | awk '{print $2}'
}

function __env_info_go {
  (( $+commands[go] )) || return
  go version 2>&1 | awk '{print $3}'
}

function __env_info_node {
  (( $+commands[node] )) || return
  node --version
}

function __update_env_info {
  local env_info_msg_0_=
  for elem in "${__env_info_list[@]}"; do
    local version="$(__env_info_${elem})"
    if [[ -z $version ]]; then
      continue
    fi
    if [[ -n "$env_info_msg_0_" ]]; then
      env_info_msg_0_="${env_info_msg_0_}]-[${elem}:%F{green}${version}%f"
    else
      env_info_msg_0_="${elem}:%F{green}${version}%f"
    fi
  done
  echo "$env_info_msg_0_"
}

###########################################################
__vi_mode_viins_symbol=
__vi_mode_vicmd_symbol="%F{green}-- NORMAL --%f"
__vi_mode_vivis_symbol="%F{yellow}-- VISUAL --%f"

__env_info_list=(
  rust
  # go
  python
  # node
  # ruby
)

function __prompt_host() {
  local color="blue"
  if [[ -n $SSH_CONNECTION ]]; then
    color="yellow"
  fi
  echo "%F{$color}[$(whoami)@%m]%f"
}

function __prompt_vcs() {
  local vcs="$(__get_vcs_info)"
  [[ -z "$vcs" ]] || echo "-$vcs"
}

function __prompt_env() {
  local env="$(__update_env_info)"
  [[ -z "$env" ]] || echo "-[$env]"
}

PROMPT='
'
PROMPT+='%B$(__prompt_host)%b'
PROMPT+='%B$(__prompt_vcs)%b'
PROMPT+='%B$(__prompt_env)%b'
PROMPT+='
%B%F{green}$(prompt_pwd)%f%b > '

RPROMPT='$(vi_mode_keymap_info)'
