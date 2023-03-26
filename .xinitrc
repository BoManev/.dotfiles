#!/usr/bin/env zsh

#. /etc/X11/Xsession

[[ -f ~/.Xresources ]] && xrdb -I$HOME ~/.Xresources

if hash dunst > /dev/null 2>&1 ; then
    dunst &
fi

if hash picom > /dev/null 2>&1 ; then
    picom -b --config $HOME/.dotfiles/picom.conf &
fi

exec i3

