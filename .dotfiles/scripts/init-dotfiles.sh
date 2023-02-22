git clone --separate-git-dir=$HOME/.dotrepo git@github.com:BoManev/.dotfiles.git tmpdotfiles
rsync --recursive --verbose --exclude '.git' tmpdotfiles/ $HOME/
rm -r tmpdotfiles
