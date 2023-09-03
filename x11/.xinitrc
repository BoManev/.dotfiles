#!/bin/sh

. /etc/X11/Xsession.d/20dbus_xdg-runtime

setxkbmap -option compose:rctrl
if test -e /usr/bin/xmodmap; then
  if test -e .Xmodmap; then
    xmodmap .Xmodmap
  fi
fi

if hash dunst > /dev/null 2>&1 ; then
    dunst &
fi

if hash picom > /dev/null 2>&1 ; then
    picom -b --config $HOME/projects/.dotfiles/i3wm/picom.conf &
fi

xsetroot -cursor_name left_ptr
exec i3 -c $HOME/projects/.dotfiles/i3wm/i3config

