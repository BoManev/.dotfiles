source $ZDOTDIR/aliases
fpath=( $ZDOTDIR/functions/ "${fpath[@]}" )
autoload -Uz $fpath[1]/*(.:t)

lazy_node
lazy_rust
lazy_z
lazy_conda
rust_gen 

repos=(
  zsh-users/zsh-completions
  zsh-users/zsh-syntax-highlighting
  zsh-users/zsh-history-substring-search
  Aloxaf/fzf-tab
)

prompt
plugin-load $repos

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[comment]='fg=magenta,bold'

autoload -Uz compinit 
if [[ -n $ZDOTDIR/.zcompdump(#qN.mh+24) ]]; then
    compinit && zcompile "$ZDOTDIR/.zcompdump"
else
    compinit -C && zcompile "$ZDOTDIR/.zcompdump"
fi;
zstyle ':completion:*' menu select

setopt interactive_comments

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey '^[[A' history-substring-search-up
bindkey '^[OA' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[OB' history-substring-search-down

# eval "$( pyenv init - --no-rehash )"
# eval "$( pip completion --zsh )"
# eval "$( pipenv --completion )"

