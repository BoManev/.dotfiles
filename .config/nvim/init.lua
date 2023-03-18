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

vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.mouse = 'v'
vim.opt.incsearch = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.guicursor = ''
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.undodir = os.getenv('HOME') .. '/tools/nvim/undodir'
vim.opt.undofile = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.cc ="80"
vim.opt.wrap = false

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('lazy').setup({
    {
       'ellisonleao/gruvbox.nvim',
       lazy = false,
       priority = 1000,
       config = function()
           vim.cmd([[colorscheme gruvbox]])
           vim.o.background = "dark"
        end
    },
    { 
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
         dependencies = { 'nvim-lua/plenary.nvim' },
         keys = {
             { '<leader>tl', '<CMD>Telescope<CR>',		mode = { 'n' } },
             { '<leader>pf', '<CMD>Telescope find_files<CR>', 	mode = { 'n' } },
             { '<leader>cs', '<CMD>Telescope commands<CR>', 	mode = { 'n' } },
             { '<leader>ks', '<CMD>Telescope keymaps<CR>', 	mode = { 'n' } },
             { '<leader>rg', '<CMD>Telescope live_grep<CR>', 	mode = { 'n' } },
             { '<leader>gf', '<CMD>Telescope git_files<CR>', 	mode = { 'n' } },
         }
    },
    {
	    "nvim-treesitter/nvim-treesitter", 
	    build = ":TSUpdate",
        config = function()
            require'nvim-treesitter.configs'.setup {
                  ensure_installed = {'c', 'lua', 'cpp', 'python', 'javascript', 'typescript', 'vim', 'help', 'query' },
                  sync_install = false,
                  auto_install = true,
                  highlight = {
                    enable = true,
                   additional_vim_regex_highlighting = false,
                  }
              }
        end
    },
})

vim.keymap.set('n', '<leader>e', vim.cmd.Ex) 
vim.keymap.set('n', '<leader>gr', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
