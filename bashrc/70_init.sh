#!/usr/bin/env bash

complete -cf sudo
eval "$(zoxide init bash)"

source /home/bo/tools/sources/fzf/shell/key-bindings.bash
source /home/bo/tools/sources/fzf/shell/completion.bash
export FZF_DEFAULT_COMMAND='fd --type f --color=never --hidden'
export FZF_DEFAULT_OPTS='--no-height'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :50 {}'"
export FZF_ATL_C_COMMAND="fd --type d . --color=never --hidden"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -50'"
source /home/bo/.dotfiles/scripts/lazy_conda.sh
source /home/bo/.dotfiles/scripts/lazy_node.sh

eval "$(pyenv init -)"
