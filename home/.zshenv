ZDOTDIR=$HOME/.dotfiles/zsh

export PYTHON_BIN_PATH="$(python3 -m site --user-base)/bin"
export PATH=$HOME/bin:/usr/local/bin:/home/bo/.foundry/bin:$PATH:$PYTHON_BIN_PATH
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"
export HISTFILE="$ZDOTDIR/.zhistory"                       
# export EDITOR=""
# export VISUAL=""

. "$HOME/.cargo/env"



