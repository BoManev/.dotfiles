source $ZDOTDIR/aliases
fpath=( $ZDOTDIR/functions/ "${fpath[@]}" )
autoload -Uz $fpath[1]/*(.:t)

lazy_node
lazy_conda

repos=(
  zsh-users/zsh-completions
  zsh-users/zsh-syntax-highlighting
  zsh-users/zsh-history-substring-search
  Aloxaf/fzf-tab
  softmoth/zsh-vim-mode
)

prompt
plugin-load $repos

autoload -Uz compinit 
pip_gen
rust_gen
fpath=( $ZDOTDIR/comps/* "${fpath[@]}" )
autoload -Uz $fpath[1]/_*

if [[ -n $ZDOTDIR/.zcompdump(#qN.mh+24) ]]; then
    compinit && zcompile "$ZDOTDIR/.zcompdump"
else
    compinit -C && zcompile "$ZDOTDIR/.zcompdump"
fi;
zstyle ':completion:*' menu select

eval "$(zoxide init zsh)"

compctl -K _pip_completion pip3
setopt interactive_comments
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[comment]='fg=magenta,bold'


bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey '^[[A' history-substring-search-up
bindkey '^[OA' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[OB' history-substring-search-down

