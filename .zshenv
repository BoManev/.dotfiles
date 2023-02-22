ZDOTDIR=$HOME/.zsh
HISTFILE=$HOME/.zsh/.zhistory
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$HOME/bin:/usr/local/bin:/home/bo/.foundry/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"
export HISTFILE="$ZDOTDIR/.zhistory"
export NVM_DIR="$HOME/.nvm" 
export SOURCES="$HOME/projects/sources"
export ZPLUGINDIR="$ZDOTDIR/plugins"                      
# export EDITOR=""
# export VISUAL=""
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

. "$HOME/.cargo/env"



