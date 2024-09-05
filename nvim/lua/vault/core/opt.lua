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
vim.opt.smartindent = true

-- viz
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 8
-- Disable sign column chars for empty lines
vim.o.fillchars = 'eob: '
-- Use a signcolumn with 1 space for git status
vim.o.signcolumn = 'yes:1'
vim.opt.colorcolumn = "81"
vim.opt.cmdheight = 0

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
vim.o.wildmode = 'list:longest'
vim.opt.shell = "/bin/fish"
vim.opt.confirm = true
vim.opt.updatetime = 50
vim.opt.spellfile = vim.fn.stdpath('config') .. '/spell/en.utf-8.add'

-- netrw
-- vim.g.netrw_banner = 0
vim.g.netrw_list_hide = vim.fn["netrw_gitignore#Hide"]()

-- folds
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = ":lua nvim_treesitter#foldexpr()"

vim.wo.cursorline = true
vim.opt.autochdir = true

vim.diagnostic.config({
  signs = false,
  virtual_text = {
    prefix = '◦',
    spacing = 0,
  },
  float = {
    border = 'rounded',
    source = true,
  },
})
