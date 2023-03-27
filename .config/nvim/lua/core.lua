-- Leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Package Manager
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Providers
vim.env.PATH = '/home/bo/tools/nvm/versions/node/v18.15.0/bin/:'.. vim.env.PATH
vim.g.loaded_node_provider = 1
vim.g.node_host_prog = '/home/bo/tools/nvm/versions/node/v18.15.0/bin/neovim-node-host'

-- Options
vim.opt.termguicolors = true

vim.opt.hlsearch = false
vim.opt.ignorecase = true     -- use /C for case sensitive search
vim.opt.smartcase = true
vim.opt.incsearch = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

vim.opt.showmatch = true

vim.opt.mouse = 'v'
vim.opt.guicursor = ''

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/tools/nvim/undodir'
vim.opt.undofile = true

vim.opt.signcolumn = 'yes'
vim.opt.cc ='80'

vim.opt.scrolloff = 8
vim.opt.wrap = false
vim.opt.laststatus = 3

vim.opt.list = true
vim.opt.listchars = 'tab:→ ,eol:↵,trail:·,extends:↷,precedes:↶'

vim.opt.completeopt = "menu,menuone,noselect,noinsert"

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.o.clipboard = 'unnamedplus'


