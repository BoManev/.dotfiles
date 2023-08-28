set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $XDG_CONFIG_HOME/local/share
set -gx XDG_CACHE_HOME $XDG_CONFIG_HOME/cache
set -gx XDG_DESKTOP_DIR $HOME
set -gx XDG_DOWNLOAD_DIR $HOME/Downloads
set -gx EDITOR nvim
set -gx BROWSER firefox
set -gx PDFVIEWER zathura
set -gx PSVIEWER zathura
set -gx MANPAGER "nvim +Man!"

set PATH /usr/local/sbin/
set PATH $PATH /usr/local/bin/
set PATH $PATH /usr/sbin/
set PATH $PATH /usr/bin/
set PATH $PATH /sbin
set PATH $PATH /bin
set PATH $PATH $HOME/.local/bin

set PATH $PATH $HOME/tools/bin

set PATH $PATH $HOME/.cargo/bin
set PATH $PATH $HOME/projects/.dotfiles/bin

set -Ux GOROOT $HOME/tools/sources/go
set -Ux GOPATH $HOME/tools/go
set PATH $PATH $GOPATH/bin

set PATH $HOME/.pyenv/bin $PATH
set -Ux PYENV_ROOT $HOME/.pyenv

eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

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



