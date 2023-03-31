local M = {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    dependencies = {
      { 'nvim-lua/plenary.nvim'},
      { 'nvim-neorg/neorg' }
    },
    keys = {
        {'<leader>tt', '<CMD>Telescope<CR>'},
        {'<leader>tf', '<CMD>Telescope find_files<CR>'},
        {'<leader>tg', '<CMD>Telescope git_files<CR>'},
        {'<leader>ts', '<CMD>Telescope live_grep<CR>'},
        {'<leader>tb', '<CMD>Telescope buffers<CR>'},
        {'<leader>tr', '<CMD>Telescope registers<CR>'},
        {'<leader>tp', '<CMD>Telescope oldfiles<CR>'},
    }
}

function M.config()
  require("telescope").load_extension("neorg")
  local actions = require("telescope.actions")
  local trouble = require("trouble.providers.telescope")

  local telescope = require("telescope")
  require('telescope').setup {
    defaults = {
      mappings = {
        i = { ["<c-t>"] = trouble.open_with_trouble },
        n = { ["<c-t>"] = trouble.open_with_trouble },
      }
    }
  }
end

return M

