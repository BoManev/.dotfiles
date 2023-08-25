#! usr/bin/env bash

alias c='clear -x' # [c]lean
alias f='clear' # [f]flush
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias shutdown='sudo shutdown now'
alias restart='sudo reboot'
alias suspend='sudo pm-suspend'
alias ll='exa --grid --icons --across'
alias la='exa --grid --icons --across --all'
alias lt='exa --tree --level=2 --icons'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -v'
alias bkill='rfkill block bluetooth'
alias blive='rfkill unblock bluetooth'
alias ppath='echo -e "${PATH//:/\\n}"'
alias gitlog='git log --graph --oneline --decorate'
alias gitmod='git submodule sync && git submodule update --remote && git pull --recurse-submodules'
# display names of running containers
alias dockls='docker container ls | awk "NR > 1 {print \$NF}"'
alias python='python3'
alias pip='pip3'
alias vpnc='protonvpn-cli connect'
alias vpnd='protonvpn-cli disconnect'
alias vpns='protonvpn-cli status'
alias mysql='sudo mysql -u root -p'
alias msql='mysql -u root -p --show-warnings'
# install terminfo for alacritty when ssh on server
alias aterminfo='wget https://raw.githubusercontent.com/alacritty/alacritty/master/extra/alacritty.info && tic -xe alacritty,alacritty-direct alacritty.info && rm alacritty.info'
alias ld='lazygit --git-dir=$HOME/.dotrepo/ --work-tree=$HOME' # [l]azy [d]otfiles
alias gd='git --git-dir=$HOME/.dotrepo/ --work-tree=$HOME' # [g]it [d]otfiles
alias benchnvim='hyperfine "nvim --headless +qa" --warmup 5'
alias ah=' annotate_history'