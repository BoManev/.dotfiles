setopt AUTO_PUSHD           
setopt PUSHD_IGNORE_DUPS    
setopt PUSHD_SILENT         

export HISTSIZE=10000                   
export SAVEHIST=10000

autoload -U compinit; compinit                      
_comp_options+=(globdots)                           
source $HOME/.dotfiles/zsh/scripts/completion       # https://thevaluable.dev/zsh-completion-guide-examples/

source $HOME/.dotfiles/zsh/.aliases
source $HOME/.dotfiles/zsh/scripts/bd

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  

fpath=(~/.dotfiles/zsh/scripts/prompt $fpath)
autoload -Uz ~/.dotfiles/zsh/scripts/prompt && prompt

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" 

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word