#!/bin/sh

export DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus"
export GDK_BACKEND=x11
export XDG_SESSION_TYPE=x11

dbus-update-activation-environment --verbose --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY

[[ -f ~/.Xresources ]] && xrdb -I$HOME ~/.Xresources

if hash dunst > /dev/null 2>&1 ; then
    dunst &
fi

if hash picom > /dev/null 2>&1 ; then
    picom -b --config $HOME/.dotfiles/picom.conf &
fi

xmodmap ~/.Xmodmap

xss-lock --transfer-sleep-lock -- i3lock --nofork &
exec i3 -c $HOME/.dotfiles/i3config

