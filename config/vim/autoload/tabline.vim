function! s:virtualenv()
  return $VIRTUAL_ENV ==# '' ? '' : fnamemodify($VIRTUAL_ENV, ':t')
endfunction

let g:tabline#rustup_toolchain = ''
function! s:rustup_toolchain()
  if g:tabline#rustup_toolchain !=# ''
    return g:tabline#rustup_toolchain
  endif
  try
    let g:tabline#rustup_toolchain = rustup#active_toolchain()
  catch
  endtry
endfunction

function! tabline#make_tabline()
  let envstatus = ''

  let venv = s:virtualenv()
  if venv !=# ''
    let envstatus = envstatus . '[venv:' . venv . ']'
  endif

  let toolchain = s:rustup_toolchain()
  if toolchain !=# ''
    let toolchain = split(toolchain, '-')[0]
    let envstatus = envstatus . '[rust:' . toolchain . ']'
  endif

  return '%=' . envstatus
endfunction
