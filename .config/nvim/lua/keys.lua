local M = {}

M.lsp_keys = function(bufnr)
  local opts = { buffer = bufnr, remap = false }
  vim.keymap.set('n', '<leader>lh', function()
    vim.lsp.buf.hover()
  end, opts)
  vim.keymap.set('n', '<leader>ld', function()
    vim.lsp.buf.definition()
  end, opts)
  vim.keymap.set('n', '<leader>lD', function()
    vim.lsp.buf.declaration()
  end, opts)
  vim.keymap.set('n', '<leader>li', function()
    vim.lsp.buf.implementation()
  end, opts)
  vim.keymap.set('n', '<leader>lt', function()
    vim.lsp.buf.type_definition()
  end, opts)
  vim.keymap.set('n', '<leader>lr', function()
    vim.lsp.buf.references()
  end, opts)
  vim.keymap.set('n', '<leader>ls', function()
    vim.lsp.buf.signature_help()
  end, opts)
  vim.keymap.set('n', '<leader>lR', function()
    vim.lsp.buf.rename()
  end, opts)
  vim.keymap.set('n', '<leader>lf', function()
    vim.lsp.buf.format()
  end, opts)
  vim.keymap.set('n', '<leader>la', function()
    vim.lsp.buf.code_action()
  end, opts)
  vim.keymap.set('n', '<leader>lx', function()
    vim.diagnostic.open_float()
  end, opts)
  vim.keymap.set('n', '<leader>ln', function()
    vim.diagnostic.goto_next()
  end, opts)
  vim.keymap.set('n', '<leader>lp', function()
    vim.diagnostic.goto_prev({})
  end, opts)
end

M.generic_keys = function()
  local wk = require('which-key')
  local bind = vim.keymap.set
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
end

return M
