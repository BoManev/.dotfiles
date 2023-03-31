#!/usr/bin/env bash

export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$XDG_CONFIG_HOME/local/share
export XDG_CACHE_HOME=$XDG_CONFIG_HOME/cache
export XDG_DESKTOP_DIR=$HOME
export XDG_DOWNLOAD_DIR=$HOME/downloads
export EDITOR=nvim
export BROWSER=firefox
export PDFVIEWER=zathura
export PSVIEWER=zathura

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
PATH=$HOME/.local/bin:$PATH
PATH=$HOME/tools/bin:$PATH
PATH=$HOME/.dotfiles/scripts/functions:$PATH

. $HOME/.cargo/env
export GOROOT=$HOME/tools/sources/go
export GOPATH=$HOME/tools/go
export NVM_DIR=$HOME/tools/nvm

export MANPAGER="nvim +Man!"
export FZF_DEFAULT_COMMAND='rg --files'
