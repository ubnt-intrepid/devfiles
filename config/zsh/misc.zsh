# vim: set ft=zsh ts=2 sw=2 et :

### history files

# location of history file.
HISTFILE=$HOME/.zsh_history

# number of stored histories in memory.
HISTSIZE=1000

# number of stored histories in $HISTFILE.
SAVEHIST=10000

# ignore duplicates in histories.
setopt hist_ignore_dups

# record beginning/end of history.
setopt extended_history


### languages
export LANG=en_US.UTF-8

### editors
export EDITOR='vim'
export VISUAL='vim'

### others

# enable comment on interactive mode
setopt interactivecomments

# do not show '%'
unsetopt promptcr

DIRSTACKSIZE=100

# push the old directory onto the stack on cd
setopt auto_pushd

# do not print the directory stack after pushd/popd
setopt pushd_silent

# do not store duplicates in the stack.
setopt pushd_ignore_dups

# do not overwrite existing files with > and >>
unsetopt clobber


zstyle ':completion:*'    menu select
zstyle ':completion:cd:*' ignore-parents parent pwd
# zstyle ':completion:*:descriptions' format '%BCompleting%b %U%d%u'

# ls colorscheme
export LS_COLORS='ex=32;4'

# set escape time [0.01s]
KEYTIMEOUT=1
