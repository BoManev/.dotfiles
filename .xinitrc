#!/bin/sh

#. /etc/X11/Xsession

[[ -f ~/.Xresources ]] && xrdb -I$HOME ~/.Xresources
dbus-update-activation-environment DISPLAY XAUTHORITY
if hash dunst > /dev/null 2>&1 ; then
    dunst &
fi

if hash picom > /dev/null 2>&1 ; then
    picom -b --config $HOME/.dotfiles/picom.conf &
fi

export GDK_BACKEND=x11

exec i3 -c $HOME/.dotfiles/i3config

