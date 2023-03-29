ZDOTDIR=$HOME/.zsh

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"
export XDG_DESKTOP_DIR="$HOME"
export XDG_DOWNLOAD_DIR="$HOME/downloads"
export EDITOR="nvim"
# export VISUAL=""

export HISTFILE="$ZDOTDIR/.zsh_history"
export ZPLUGINDIR="$ZDOTDIR/plugins" 
export SAVEHIST=10000000
export HISTSIZE=10000000
setopt HIST_EXPIRE_DUPS_FIRST
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt HIST_VERIFY
setopt NO_EXTENDED_HISTORY

PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
PATH="$HOME/.local/bin:$PATH"
PATH="$HOME/tools/bin:$PATH"
 
source "$HOME/.cargo/env"
export GOROOT="$HOME/tools/sources/go"
export GOPATH="$HOME/tools/go"
export NVM_DIR="$HOME/tools/nvm"

export MANPAGER='nvim +Man!'
