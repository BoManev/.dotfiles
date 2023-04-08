local utils = require('utils')
local wk = require('which-key')
local bind = vim.keymap.set
local opts = { noremap = true }

wk.register({
  ['<leader>s'] = {
    name = '[S]witch',
    ['s'] = { utils.toggle_opt('spell', 'o', true, false), '[s]pell' },
    ['c'] = { utils.toggle_opt('colorcolumn', 'wo', '81', '0'), '[c]olumn' },
  },
  ['<leader>b'] = {
    name = '[B]uffer',
    ['q'] = { '<cmd>bdelete<cr>', 'close' },
    ['l'] = { '<cmd>buffer #<cr>', '[l]ast' },
  },
  ['['] = {
    ['b'] = { '<cmd>bprevious<cr>', 'prev buf' },
    ['t'] = { '<cmd>tabprevious<cr>', 'prev tap' },
  },
  [']'] = {
    ['b'] = { '<cmd>bnext<cr>', 'next buf' },
    ['t'] = { '<cmd>tabnext<cr>', 'next tap' },
  },
})

-- open file explorer
bind('n', '<leader>e', vim.cmd.E, opts)

-- yank to clipboard
bind({ 'n', 'v' }, '<leader>y', [["+y]], opts)

-- don't save to register
bind('n', 'x', '"_x')

-- no copy on past
bind("v", "p", '"_dP')

-- Open new tabpage
bind('n', '<Leader>tn', ':tabnew<CR>')

-- movement with wrapped lines
bind('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
bind('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
