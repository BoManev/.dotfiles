local M = {
    'nvim-telescope/telescope.nvim', branch = 'master',
    dependencies = {
      { 'nvim-lua/plenary.nvim'},
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
  local actions = require("telescope.actions")
  local trouble = require("trouble.providers.telescope")

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

