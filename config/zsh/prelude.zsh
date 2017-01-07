# vim: set ft=zsh ts=2 sw=2 et :

### Setup environment variables

# make csh-style environment variables
typeset -T LD_LIBRARY_PATH    ld_library_path
typeset -T C_INCLUDE_PATH     c_include_path
typeset -T CPLUS_INCLUDE_PATH cplus_include_path
typeset -T LIBRARY_PATH       library_path
export LD_LIBRARY_PATH C_INCLUDE_PATH CPLUS_INCLUDE_PATH LIBRARY_PATH

# Add `unique` attribute to the variables
typeset -U path               PATH
typeset -U ld_library_path    LD_LIBRARY_PATH
typeset -U c_include_path     C_INCLUDE_PATH
typeset -U cplus_include_path CPLUS_INCLUDE_PATH
typeset -U library_path       LIBRARY_PATH

path=(
  $HOME/.local/bin(N-/)
  $path
)

fpath=(
  $HOME/.local/share/zsh/site-functions(N-/)
  $HOME/.zsh.d/functions/*(N-/)
  $fpath
)
