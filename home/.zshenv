ZDOTDIR=$HOME/.dotfiles/zsh

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export VIVADO_ROOT="/tools/Xilinx/Vivado/2022.1/bin/"
export VITIS_ROOT="/tools/Xilinx/Vitis_HLS/2022.1/bin/"
export PATH="$HOME/bin:/usr/local/bin:/home/bo/.foundry/bin:$PATH:$VIVADO_ROOT:$VITIS_ROOT"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"
export HISTFILE="$ZDOTDIR/.zhistory"                       
# export EDITOR=""
# export VISUAL=""

. "$HOME/.cargo/env"



