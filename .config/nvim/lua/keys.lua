local wk = require('which-key')
local bind = vim.keymap.set

-- next tab
bind('n', '[t', ':tprevious<CR>')

-- previous tab
bind('n', ']t', ':tnext<CR>')

-- next buffer
bind('n', '[b', ':bprevious<CR>')

-- previous buffer
bind('n', ']b', ':bnext<CR>')

-- close buffer
bind('n', '<leader>bq', ':bdelete<CR>')

-- open last buffer
bind('n', '<leader>bl', ':buffer #<CR>')

-- toggle spell
bind('n', '<leader>ss', ':lua require("utils").toggle_opt("spell", "o", true, false)()<CR>')

-- toggle line column 
bind('n', '<leader>sc', ':lua require("utils").toggle_opt("colorcolumn", "wo", "81", "0")()<CR>')

-- open file explorer
bind('n', '<leader>e', vim.cmd.E)

-- yank to clipboard
bind({ 'n', 'v' }, '<leader>y', [["+y]])

-- don't save to register
bind('n', 'x', '"_x')

-- no copy on past
bind('v', 'p', '"_dP')

-- Open new tabpage
bind('n', '<Leader>tn', ':tabnew<CR>')

-- movement with wrapped lines
bind('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
bind('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

wk.register({
  ['<leader>s'] = {
    name = '[S]witch',
    ['s'] = '[S]pell',
    ['c'] = '[c]olumn'
  },
  ['<leader>b'] = {
    name = '[B]uffer',
    ['q'] = '[q]uit',
    ['l'] = '[l]ast'
  },
  ['['] = {
    ['b'] = 'prev [b]uf',
    ['t'] = 'prev [t]ap'
  },
  [']'] = {
    ['b'] = 'next [b]uf',
    ['t'] = 'next [t]ap'
  },
})

