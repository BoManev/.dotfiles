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

set -Ux GODIR $HOME/tools/go
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
eval "$(pyenv virtualenv-init -)"

atuin init fish | source

# <A+e> - open line with $EDITOR
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
