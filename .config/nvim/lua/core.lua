-- Leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Providers
vim.env.PATH = '/home/bo/tools/nvm/versions/node/v18.15.0/bin/:' .. vim.env.PATH
--vim.g.node_host_prog = '/home/bo/tools/nvm/versions/node/v18.15.0/bin/nvim-node-host'
--vim.g.loaded_node_provider = 1
if os.getenv('CONDA_PREFIX') ~= nil and os.getenv('CONDA_PREFIX') ~= '' then
  vim.g.python3_host_prog = vim.env.CONDA_PREFIX .. '/bin/python3'
  vim.g.loaded_python3_provide = 1
else
  vim.g.loaded_python3_provider = 0
end
-- Options
vim.opt.termguicolors = true

vim.opt.hlsearch = false
vim.opt.ignorecase = true -- use /C for case sensitive search
vim.opt.smartcase = true
vim.opt.incsearch = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.copyindent = true
vim.opt.smartindent = true
vim.opt.preserveindent = true

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

vim.opt.signcolumn = 'auto:1-3'
vim.opt.cc = '81'

vim.opt.scrolloff = 8
vim.opt.wrap = false
vim.opt.laststatus = 3

vim.opt.list = true
vim.opt.listchars = 'tab:→ ,eol:↵,trail:·,extends:↷,precedes:↶'

vim.opt.completeopt = { 'menu', 'menuone', 'noinsert' }
vim.opt.wildmenu = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.confirm = true
vim.opt.iskeyword:append('-')

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
local builtins = {
  "tar",
  "zip",
  "gzip",
  "tarPlugin",
  "zipPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
}
for _, builtin in ipairs(builtins) do
  vim.g["loaded_" .. builtin] = 1
end
--local providers = { "perl", "node", "ruby", "python", "python3" }
--for _, provider in ipairs(providers) do
--  vim.g["loaded_" .. provider .. "_provider"] = 0
--end
