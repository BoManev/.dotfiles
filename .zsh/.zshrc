fpath=( $ZDOTDIR/before/ "${fpath[@]}" )
autoload -Uz $fpath[1]/*(.:t)

rust_gen 
z_gen

fpath=( $ZDOTDIR/lazy/ "${fpath[@]}" )
autoload -Uz $fpath[1]/*(.:t)

fpath=( $ZDOTDIR/functions/ "${fpath[@]}" )
autoload -Uz $fpath[1]/*(.:t)

repos=(
  zsh-users/zsh-completions
  zsh-users/zsh-syntax-highlighting
  zsh-users/zsh-history-substring-search
  Aloxaf/fzf-tab
)

prompt
plugin-load $repos

autoload -Uz compinit 
if [[ -n $ZDOTDIR/.zcompdump(#qN.mh+24) ]]; then
    compinit && zcompile "$ZDOTDIR/.zcompdump"
else
    compinit -C && zcompile "$ZDOTDIR/.zcompdump"
fi;
zstyle ':completion:*' menu select

z_gen
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
#export PATH="/home/bo/.pyenv/versions/miniconda3-latest/bin:$PATH"



source $ZDOTDIR/aliases

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey '^[[A' history-substring-search-up
bindkey '^[OA' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[OB' history-substring-search-down

#   TODO
# functions to modify (f)path

#   if [ $commands[kubectl] ]; then
    # fun() {
    #     unfunction "$0"
    #     source <(kubectl completion zsh)
    #     $0 "$@"
    # }

    #     eval "$(command rbenv init -)"


# eval "$( pyenv init - --no-rehash )"
# eval "$( pip completion --zsh )"
# eval "$( pipenv --completion )"
# eval "source $NVM_DIR/nvm.sh && source $NVM_DIR/bash_completion"