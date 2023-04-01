#!/usr/bin/env bash

shopt -s histappend
set +o histexpand
HISTCONTROL=ignoreboth
# infinity history
HISTFILESIZE=
HISTSIZE=
HISTTIMEFORMAT="%F %T "
HISTIGNORE="ls:ll:lt:la:nvim*:cd *:pwd:bg *:fg *:history"
