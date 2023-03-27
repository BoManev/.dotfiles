#!/bin/sh

#. /etc/X11/Xsession
 DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus"
  export DBUS_SESSION_BUS_ADDRESS

  dbus-update-activation-environment --verbose --systemd \
    DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY
[[ -f ~/.Xresources ]] && xrdb -I$HOME ~/.Xresources

if hash dunst > /dev/null 2>&1 ; then
    dunst &
fi

if hash picom > /dev/null 2>&1 ; then
    picom -b --config $HOME/.dotfiles/picom.conf &
fi

export GDK_BACKEND=x11

exec i3 -c $HOME/.dotfiles/i3config

