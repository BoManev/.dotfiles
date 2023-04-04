local M = {
  'folke/trouble.nvim',
  cmd = {'Trouble'},
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'nvim-telescope/telescope.nvim'
  },
  keys = {
    {'<leader>dd', '<CMD>TroubleToggle<CR>'},
    {'<leader>dw', '<CMD>TroubleToggle workspace_diagnostics<CR>'},
    {'<leader>dc', '<CMD>TroubleToggle document_diagnostics<CR>'},
    {'<leader>dl', '<CMD>TroubleToggle loclist<CR>'},
    {'<leader>dq', '<CMD>TroubleToggle quickfix<CR>'},
    {'<leader>dr', '<CMD>TroubleToggle lsp_references<CR>'},
  }
}

function M.config()
end

return M
