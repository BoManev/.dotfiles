#!usr/bin/env bash

lazy_node() {
    unset -f nvm node npm pnpm yarn 
    # Load nvm if it exists in $NVM_DIR
    [[ -f "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
    command "$@"
}

nvm() { lazy_node nvm "$@"; }
node() { lazy_node node "$@"; }
npm() { lazy_node npm "$@"; }
pnpm() { lazy_node pnpm "$@"; }
yarn() { lazy_node yarn "$@"; }
