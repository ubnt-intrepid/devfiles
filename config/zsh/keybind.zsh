# vim: set ft=zsh ts=2 sw=2 et :

### ensure to use Vi keybind
bindkey -v

### Updates editor information when the keymap changes
function __zle_reset_prompt {
  zle reset-prompt
  zle -R
}

zle -N zle-keymap-select __zle_reset_prompt
zle -N zle-line-init __zle_reset_prompt

### Additional key bindings
# allow `v` to edit the command line.
# autoload -Uz edit-command-line
# zle -N edit-command-line
# bindkey -M vicmd 'v' edit-command-line

# ctrl+p, ctrl+n : navigate history
bindkey -M viins '^p' up-history
bindkey -M viins '^n' down-history

# ctrl+a, ctrl+e : move to beginning/end of line
bindkey -M viins '^a' beginning-of-line
bindkey -M viins '^e' end-of-line

### Show current keymap mode in Zsh
# __vi_mode_viins_symbol="${__vi_mode_viins_symbol:-(insert)}"
# __vi_mode_vicmd_symbol="${__vi_mode_vicmd_symbol:-(command)}"
# __vi_mode_vivis_symbol="${__vi_mode_vivis_symbol:-(visual)}"

function vi_mode_keymap_info() {
  case $KEYMAP in
    main|viins)
      echo "${__vi_mode_viins_symbol}"
      ;;
    vicmd)
      echo "${__vi_mode_vicmd_symbol}"
      ;;
    vivis)
      echo "${__vi_mode_vivis_symbol}"
      ;;
  esac
}
