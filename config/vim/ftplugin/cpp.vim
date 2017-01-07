function! s:cplusplus_setup_msys2()
endfunction

function! s:cplusplus_setup_mingw()
  setlocal path+=c:/msys64/mingw64/include
endfunction

function! s:cplusplus_setup_linux()
  setlocal path+=~/.local/opt/gurobi652/linux64/include
endfunction

function! s:cplusplus_setup() " {{{
  if has('win32') && has('win64')
    " Win32 native (GVim)
    call s:cplusplus_setup_mingw()

  elseif has('win32unix') " Cygwin / MSYS2
    if !empty($MSYSTEM) " MSYS2's Vim
      if $MSYSTEM =~# 'MINGW64'
        " MinGW-w64 x86_64 Shell
        call s:cplusplus_setup_mingw()
      else
        " MSYS2 Shell
        call s:cplusplus_setup_msys2()
      endif
    endif
  elseif has('unix')
    " Linux
    call s:cplusplus_setup_linux()
  endif
endfunction " }}}

call s:cplusplus_setup()

" neocomplete
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.cpp =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'

" vim-clang
let g:clang_auto = 0
let g:clang_cpp_completeopt = 'menuone'
