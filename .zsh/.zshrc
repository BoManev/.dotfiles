function plugin-load {
  local repo plugdir initfile
  if [[ ! -d $ZPLUGINDIR ]]; then
    echo "Creating plugin directory..."
    mkdir $ZPLUGINDIR
  fi
  for repo in $@; do
    plugdir=$ZPLUGINDIR/${repo:t}
    initfile=$plugdir/${repo:t}.plugin.zsh
    if [[ ! -d $plugdir ]]; then
      echo "Cloning $repo..."
      git clone -q --depth 1 --recursive --shallow-submodules https://github.com/$repo $plugdir
    fi
    if [[ ! -e $initfile ]]; then
      local -a initfiles=($plugdir/*.plugin.{z,}sh(N) $plugdir/*.{z,}sh{-theme,}(N))
      (( $#initfiles )) || { echo >&2 "No init file found '$repo'." && continue }
      ln -sf "${initfiles[1]}" "$initfile"
    fi
    fpath+=$plugdir
    (( $+functions[zsh-defer] )) && zsh-defer . $initfile || . $initfile
  done
}

repos=(
  rupa/z
  zsh-users/zsh-syntax-highlighting
  zsh-users/zsh-history-substring-search
  Aloxaf/fzf-tab
)
plugin-load $repos

fpath=( $ZDOTDIR/functions/ "${fpath[@]}" )
autoload -Uz $fpath[1]/*(.:t)

prompt
source $ZDOTDIR/aliases

autoload -Uz compinit 
if [[ -n $ZDOTDIR/.zcompdump(#qN.mh+24) ]]; then
    compinit && zcompile "$ZDOTDIR/.zcompdump"
else
    compinit -C && zcompile "$ZDOTDIR/.zcompdump"
fi;
zstyle ':completion:*' menu select

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey '^[[A' history-substring-search-up
bindkey '^[OA' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[OB' history-substring-search-down

#   TODO
# functions to modify (f)path
# lazy load functions
#   if [ $commands[kubectl] ]; then
    # fun() {
    #     unfunction "$0"
    #     source <(kubectl completion zsh)
    #     eval "$(command rbenv init -)"
    #     $0 "$@"
    # }
# 'rustup  completions zsh'
# 'rustup  completions zsh cargo'
# eval "$( pyenv init - --no-rehash )"
# eval "$( pip completion --zsh )"
# eval "$( pipenv --completion )"
#   eval "source $NVM_DIR/nvm.sh && source $NVM_DIR/bash_completion"
# compctl -K    _nvm nvm
# compdef       _pipenv pipenv
# compctl -K    _pip_completion pip
# compctl -K    _pyenv pyenv