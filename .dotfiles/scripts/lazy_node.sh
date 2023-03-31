#!usr/bin/env bash

lazy_node() {
    unfunction nvm node npm pnpm yarn 
    # Load nvm if it exists in $NVM_DIR
    [[ -f "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
    "$0" "$@"
}

nvm() { nvm_node_npm_pnpm_yarn nvm "$@"; }
node() { nvm_node_npm_pnpm_yarn node "$@"; }
npm() { nvm_node_npm_pnpm_yarn npm "$@"; }
pnpm() { nvm_node_npm_pnpm_yarn pnpm "$@"; }
yarn() { nvm_node_npm_pnpm_yarn yarn "$@"; }
