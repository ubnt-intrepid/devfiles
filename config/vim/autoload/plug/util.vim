" check if plug.vim exists and install if not
function! plug#util#install()
  let l:plug_url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  let l:plug_src = expand('~/.vim/autoload/plug.vim')

  if !filereadable(l:plug_src)
    call system('curl -fLo ' . l:plug_src . ' --create-dirs ' . l:plug_url)
  endif
endfunction
