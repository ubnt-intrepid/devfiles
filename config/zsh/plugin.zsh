# vim: set ft=zsh ts=2 sw=2 et :

# zgen {{{1
function install-zgen {
  [[ -d "$HOME/.zgen" ]] || git clone https://github.com/tarjoilija/zgen.git "$HOME/.zgen"
}
install-zgen

if [[ -s "$HOME/.zgen/zgen.zsh" ]]; then
  source "$HOME/.zgen/zgen.zsh"
  if ! zgen saved; then
    zgen load zsh-users/zsh-syntax-highlighting
    zgen load zsh-users/zsh-completions
    if [[ $OSTYPE != "msys" ]]; then
      zgen load zsh-users/zsh-autosuggestions
    fi
    zgen load b4b4r07/zsh-vimode-visual
    zgen save
  fi
fi


# OPAM (OCaml Package Manager) {{{1
export OCAMLPARAM='_,bin-annot=1'
export OPAMKEEPBUILDDIR=1

if [[ -s "$HOME/.opam/opam-init/init.zsh" ]]; then
  source "$HOME/.opam/opam-init/init.zsh"
fi


# Golang {{{1
export GOPATH=${GOPATH:-"$HOME/.go"}
case $OSTYPE in
  *msys*)
    export GOPATH="$(cygpath $GOPATH)"
    ;;
esac

path=(
  $GOPATH/bin(N-/)
  $path
)


# Python {{{1
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUAL_ENV_DISABLE_PROMPT=1

function install-pyenv {
  local PYENV_ROOT="$HOME/.pyenv"
  # check if pyenv and pyenv-virtualenv are installed.
  [[ -d "$PYENV_ROOT" ]] || git clone https://github.com/yyuu/pyenv.git "$PYENV_ROOT"
  [[ -d "$PYENV_ROOT/plugins/pyenv-virtualenv" ]] || git clone https://github.com/yyuu/pyenv-virtualenv.git "$PYENV_ROOT/plugins/pyenv-virtualenv"
  if (( $+commands[apt-get] )); then
    sudo apt-get install -y libssl-dev libbz2-dev libsqlite3-dev
  elif (( $+commands[dnf] )); then
    sudo dnf install -y zlib-devel openssl-devel bzip2-devel sqlite-devel
  fi
}

path=(
  $HOME/.pyenv/bin(N-/)
  $path
)

if (( $+commands[pyenv] )); then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
else
  # Virtualenvwrapper
  if (( $+commands[virtualenvwrapper.sh] )); then
    source $commands[virtualenvwrapper.sh]
  fi
fi


# NVM {{{1
export NVM_DIR="$HOME/.nvm"
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
  source "$NVM_DIR/nvm.sh"
fi


# Ruby {{{1
export GEM_HOME="$HOME/.gems"

path=(
  $GEM_HOME/bin(N-/)
  $path
)

if [[ -s "$HOME/.travis/travis.sh" ]]; then
  source "$HOME/.travis/travis.sh"
fi


# Rust {{{1
export CARGO_HOME="$HOME/.cargo"

path=(
  $CARGO_HOME/bin(N-/)
  $path
)

function cargo_zsh_fpath {
  echo "$(rustc --print sysroot)/share/zsh/site-functions"
}

function get-rustup-toolchain {
  if (( $+commands[rustc] )); then
    basename `rustc --print sysroot` | cut -d '-' -f 1
  fi
}

# Vagrant {{{1
path=(
  $path
  /c/{opt,tools}/vagrant/bin(N-/)
)

# Docker {{{1
function install-docker-ubuntu() {
	echo "not implemented."
}

function install-docker-fedora() {
  sudo dnf install -y docker
  sudo systemctl enable docker.service
  sudo systemctl start docker.service
  sudo groupadd docker || true
  sudo usermod -aG docker $USER
  echo -e '\033[1;32mbefore using docker, you should restart the computer and log back in.\033[0m'
}

function install-docker() {
	if [[ -e /etc/debian_version ]] || [[ -e /etc/debian_release ]]; then
		if [[ -e /etc/lsb-release ]]; then
			distri_name="ubuntu"
		fi
	elif [[ -e /etc/fedora-release ]]; then
		distri_name="fedora"
	fi
	if [[ -z $distri_name ]]; then
		echo "This distribution has not supported yet."
		return
	fi
	eval "install-docker-$distri_name"
}

# Gurobi {{{1
function setup-gurobi {
  [[ ! -d $HOME/.local/opt ]] || return

  case $OSTYPE in
    *linux*)
      if [[ "x$GUROBI_HOME" = "x" ]]; then
        GUROBI_HOME="$(find $HOME/.local/opt -mindepth 1 -maxdepth 1 -type d | grep -e "$HOME/.local/opt/"'gurobi[0-9]*$' | sort -r | head -n1)/linux64"
      fi

      if [[ -d "$GUROBI_HOME" ]]; then
        export GUROBI_HOME
        export GRB_LICENSE_FILE="$GUROBI_HOME/gurobi.lic"

        case $OSTYPE in
          *cygwin*|*msys*)
            path=(
              $path
              $(cygpath -u $GUROBI_HOME)/bin(N-/)
            )
            ;;
          *)
            path=(
              $path
              $GUROBI_HOME/bin(N-/)
            )
            ;;
        esac

        ld_library_path=(
          $ld_library_path
          $GUROBI_HOME/lib(N-/)
        )

        c_include_path=(
          $c_include_path
          $GUROBI_HOME/include(N-/)
        )

        cplus_include_path=(
          $cplus_include_path
          $GUROBI_HOME/include(N-/)
        )

        library_path=(
          $library_path
          $GUROBI_HOME/lib(N-/)
        )
      fi
      ;;
  esac
}

# Boost {{{1
function setup-boost {
  local BOOST_ROOT="$HOME/.local/opt/boost-1.61.0"
  [[ -d "$BOOST_ROOT" ]] || return

  export BOOST_ROOT

  ld_library_path=(
    $BOOST_ROOT/lib(N-/)
    $ld_library_path
  )

  cplus_include_path=(
    $BOOST_ROOT/include(N-/)
    $cplus_include_path
  )

  library_path=(
    $BOOST_ROOT/lib(N-/)
    $library_path
  )
}