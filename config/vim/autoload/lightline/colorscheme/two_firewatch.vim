" =============================================================
" Filename: autoload/lightline/colorscheme/two_firewatch.vim
" Author: ubnt-intrepid
" License: MIT
" Last Change: 2016-12-12 01:20.
" =============================================================

" Basics:
let s:foreground        = '#896724'
let s:foreground_light  = '#b99852'
let s:background = '#f2f0ea'

" Statusline:
let s:statusline_active_fg    = s:foreground
let s:statusline_active_bg    = s:background
let s:statusline_inactive_fg  = s:foreground
let s:statusline_inactive_bg  = s:background

" Tabline:
let s:tabline_fg          = s:foreground
let s:tabline_bg          = s:background
let s:tabline_active_fg   = s:background
let s:tabline_active_bg   = s:foreground
let s:tabline_inactive_fg = s:tabline_fg
let s:tabline_inactive_bg = s:tabline_bg

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

" Base:
let s:p.normal.middle   = [ [ s:statusline_active_fg    , s:statusline_active_bg   ] ]
let s:p.inactive.middle = [ [ s:statusline_inactive_fg  , s:statusline_inactive_bg ] ]
let s:p.tabline.middle  = [ [ s:tabline_fg              , s:tabline_bg             ] ]

" Left:
let s:p.normal.left   = [ ['darkestgreen', 'brightgreen', 'bold'] , [s:background, s:foreground] ]
let s:p.insert.left   = [ ['darkestcyan', 'white', 'bold']        , [s:background, s:foreground] ]
let s:p.replace.left  = [ ['white', 'brightred', 'bold']          , [s:background, s:foreground] ]
let s:p.visual.left   = [ ['darkred', 'brightorange', 'bold']     , [s:background, s:foreground] ]
let s:p.inactive.left = [ [ s:statusline_inactive_fg, s:statusline_inactive_bg ] ]

" Right:
let s:p.normal.right    = [ [s:foreground, s:background] , [s:background, s:foreground_light], [s:background, s:foreground] ]
let s:p.insert.right    = copy(s:p.normal.right)
let s:p.replace.right   = copy(s:p.normal.right)
let s:p.inactive.right  = [ [ s:statusline_inactive_fg, s:statusline_inactive_bg ] ]

" Tabline:
let s:p.tabline.tabsel  = [ [ s:tabline_active_fg   , s:tabline_active_bg   ] ]
let s:p.tabline.left    = [ [ s:tabline_inactive_fg , s:tabline_inactive_bg ] ]
let s:p.tabline.right   = copy(s:p.normal.right)

" Other:
let s:p.normal.error    = [ [ 'gray9', 'brightestred' ] ]
let s:p.normal.warning  = [ [ 'gray1', 'yellow' ] ]

" construct palette
let g:lightline#colorscheme#two_firewatch#palette = lightline#colorscheme#fill(s:p)
