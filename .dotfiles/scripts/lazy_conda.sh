#!/usr/bin/env bash

function conda() {
    unset -f conda
    __conda_setup="$('/home/bo/tools/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/home/bo/tools/miniconda3/etc/profile.d/conda.sh" ]; then
            . "/home/bo/tools/miniconda3/etc/profile.d/conda.sh"
        else
            export PATH="/home/bo/tools/miniconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    command conda "$@"
}