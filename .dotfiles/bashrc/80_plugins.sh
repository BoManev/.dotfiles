#!/usr/bin/env bash

repos=(
'lincheney/fzf-tab-completion'
)

PLUGINDIR=$XDG_CONFIG_HOME/shplugins
if [ ! -d $PLUGINDIR ]; then
  mkdir -p $PLUGINDIR
fi

for repo  in "${repos[@]}"; do
    plugdir=$PLUGINDIR/$(basename "$repo")
    if [[ ! -d $plugdir ]]; then
        echo "Cloning $repo..."
        git clone -q --depth 1 --recursive --shallow-submodules https://github.com/$repo $plugdir
    fi
done

source $PLUGINDIR/${repos[0]#*/}/bash/fzf-bash-completion.sh
bind -x '"\t": fzf_bash_completion'
