-- TODO
vim.opt.laststatus = 3

-- leaders
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- search
vim.opt.hlsearch = false
vim.opt.ignorecase = true -- use /C for case sensitive search
vim.opt.smartcase = true
vim.opt.incsearch = true

-- tab
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- indent
vim.opt.autoindent = true
vim.opt.copyindent = true
vim.opt.smartindent = true
vim.opt.preserveindent = true

-- viz
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.signcolumn = 'auto:1-2'
vim.opt.colorcolumn = "81"
-- mouse in visual mode
vim.opt.mouse = 'v'
vim.opt.guicursor = ''
-- highlight matching paren
vim.opt.showmatch = true

-- window
vim.opt.splitright = true
vim.opt.splitbelow = true

-- core
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true
vim.opt.isfname:append("@-@")
vim.opt.completeopt = { 'menu', 'menuone', 'noinsert' }
vim.opt.wildmenu = true
vim.opt.shell = "/bin/fish"
vim.opt.confirm = true
vim.opt.updatetime = 50
vim.opt.spellfile = vim.fn.stdpath('config') .. '/spell/en.utf-8.add'

-- providers and builtins
local builtins = {
    'tar',
    'zip',
    'gzip',
    'tarPlugin',
    'zipPlugin',
    'getscript',
    'getscriptPlugin',
    'vimball',
    'vimballPlugin',
    '2html_plugin',
    'logipat',
    'rrhelper',
}
for _, builtin in ipairs(builtins) do
    vim.g['loaded_' .. builtin] = 1
end

local providers = { 'perl', 'node', 'ruby', 'python3', 'python' }
for _, provider in ipairs(providers) do
    vim.g['loaded_' .. provider .. '_provider'] = 0
end
