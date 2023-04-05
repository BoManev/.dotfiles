#!/usr/bin/env bash

shopt -s histappend
set +o histexpand
HISTCONTROL=ignoreboth
# infinity history
HISTFILESIZE=
HISTSIZE=
HISTTIMEFORMAT="%F %T "
HISTIGNORE="ls:\
ll:\
lt:\
la:\
nvim*:\
cd *:\
pwd:\
bg *:\
bg:\
fg:\
fg *:\
history:\
history *:\
clear:\
c:\
f:\
z:\
z *:\
dotfiles:\
dotfiles *"
