function! colorscheme#change(name, bg)
  try
    if has('termguicolors')
      set termguicolors
    endif
    execute 'set background=' . a:bg
    execute 'colorscheme ' . a:name
    if exists('g:airline#themes#' . a:name . '#palette')
      let g:airline_theme = a:name
    endif
  catch
    if has('termguicolors')
      set notermguicolors
    endif
    colorscheme desert
    let g:airline_theme = 'dark'
  endtry

  " overwrite colorscheme for GitGutter
  let ctermbg = synIDattr(synIDtrans(hlID('Normal')), 'bg', 'cterm')
  let guibg   = synIDattr(synIDtrans(hlID('Normal')), 'bg', 'gui')
  exec 'hi SignColumn ctermbg='.ctermbg.' guibg='.guibg
  exec 'hi FoldColumn ctermbg='.ctermbg.' guibg='.guibg

  exec 'hi GitGutterAdd    ctermbg='.ctermbg.' guibg='.guibg
  exec 'hi GitGutterChange ctermbg='.ctermbg.' guibg='.guibg

  " remove all attributes from CursorLine
  hi CursorLine cterm=NONE gui=NONE
endfunction
