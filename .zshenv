ZDOTDIR=$HOME/.zsh

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"
export XDG_DESKTOP_DIR="$HOME"                     
export EDITOR="nvim"
# export VISUAL=""

export HISTFILE="$ZDOTDIR/.zsh_history"
export ZPLUGINDIR="$ZDOTDIR/plugins" 
export SAVEHIST=10000
export HISTSIZE=10000  
setopt AUTO_PUSHD           
setopt PUSHD_IGNORE_DUPS    
setopt PUSHD_SILENT         
setopt inc_append_history
setopt share_history
setopt HIST_IGNORE_SPACE
setopt hist_ignore_dups
setopt HIST_VERIFY

export PATH="$HOME/tools/bin:$PATH"

source "$HOME/.cargo/env"
export GOROOT="$HOME/tools/sources/go"
export GOPATH="$HOME/tools/go"
export NVM_DIR="$HOME/tools/nvm"
