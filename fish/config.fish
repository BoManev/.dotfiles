set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $XDG_CONFIG_HOME/local/share
set -gx XDG_CACHE_HOME $XDG_CONFIG_HOME/cache
set -gx XDG_DESKTOP_DIR $HOME
set -gx XDG_DOWNLOAD_DIR $HOME/Downloads

set -gx EDITOR nvim
set -gx BROWSER firefox
set -gx PDFVIEWER zotero
set -gx PSVIEWER zotero
set -gx MANPAGER "nvim +Man!"

set -Ux TOOLS $HOME/tools
set PATH $PATH $TOOLS/bin
set PATH $PATH $TOOLS/neovim/bin

set PATH $PATH $HOME/.cargo/bin

set -Ux GODIR $TOOLS/go
set -Ux GOROOT $GODIR/go-1.21
set -Ux GOPATH $GODIR/packages
set PATH $PATH $GOROOT/bin

set PATH $HOME/.pyenv/bin $PATH
set -Ux PYENV_ROOT $HOME/.pyenv

set -Ux PROJECTS $HOME/projects
set -Ux DOTFILES $PROJECTS/.dotfiles
set PATH $PATH $DOTFILES/bin

# sudo apt-get install build-essential libbz2-dev libncurses5-dev libncursesw5-dev libffi-dev libreadline-dev libssl-dev libsqlite3-dev liblzma-dev zlib1g-dev tk-dev
eval "$(pyenv init --path)"
eval "$(pyenv init -)"


set -Ux FZF_DEFAULT_OPTS """
  --height 75% --multi --reverse --margin=0,1
  --bind ctrl-f:page-down,ctrl-b:page-up
  --bind pgdn:preview-page-down,pgup:preview-page-up
  --marker='✚' --pointer='▶' --prompt='❯ '
  --no-separator --scrollbar='█' --border
  --color bg+:#262626,fg+:#dadada,hl:#f09479,hl+:#f09479
  --color border:#303030,info:#cfcfb0,header:#80a0ff,spinner:#36c692
  --color prompt:#87afff,pointer:#ff5189,marker:#f09479
"""
set -Ux FZF_DEFAULT_COMMAND "fd --type f --color=never"
set -Ux _ZO_MAXAGE "20000"
set -Ux _ZO_FZF_OPTS $FZF_DEFAULT_OPTS
set -Ux _ZO_FZF_OPTS """
    $FZF_DEFAULT_OPTS --no-multi --no-sort  --exit-0 --select-1
"""
if command -sq zoxide
    zoxide init fish | source
else
    echo 'zoxide: command not found, please install it from https://github.com/ajeetdsouza/zoxide'
end

eval "$(pyenv virtualenv-init -)"

# <A+e> - open line with $EDITOR
# fish autosuggestions
# <C+f> - accept suggestion
# <A+f> - accept first suggested word

# .. -> z ./..
# ... -> z ./../..
function multicd
    echo z (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end

abbr -a benchnvim 'hyperfine "nvim --headless +qa" --warmup 5'
# install terminfo for alacritty when in ssh
abbr -a aterminfo 'wget https://raw.githubusercontent.com/alacritty/alacritty/master/extra/alacritty.info && tic -xe alacritty,alacritty-direct alacritty.info && rm alacritty.info'
abbr -a dls 'docker container ls | awk "NR > 1 {print \$NF}"' # [d]ocker [l]i[s]t
abbr -a glog 'git log --graph --oneline --decorate' # [g]it [log]
abbr -a gss 'git submodule sync && git submodule update --remote && git pull --recurse-submodules' # [g]it [s]ync [s]ubmodules
abbr -a ll 'exa --grid --icons --across'
abbr -a la 'exa --grid --icons --across --all'
abbr -a lt 'exa --tree --level=2 --icons'
abbr -a cp 'cp -iv'
abbr -a mv 'mv -iv'
abbr -a rm 'rm -v'
abbr -a c 'clear -x' # [c]lean
abbr -a f 'clear' # [f]flush
abbr -a --position anywhere dots '~/projects/.dotfiles/'
abbr -a kubectl 'minikube kubectl --'


if test -f /home/bo/tools/google-cloud-sdk/path.fish.inc
    source /home/bo/tools/google-cloud-sdk/path.fish.inc
end

