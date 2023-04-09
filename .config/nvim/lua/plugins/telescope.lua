local M = {
  'nvim-telescope/telescope.nvim',
  branch = 'master',
  cmd = 'Telescope',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
  },
  keys = {
    { '<leader>ft', '<CMD>Telescope<CR>' },
    { '<leader>fg', '<CMD>Telescope git_files<CR>' },
    { '<leader>ff', '<CMD>Telescope find_files<CR>' },
    { '<leader>fs', '<CMD>Telescope live_grep<CR>' },
    { '<leader>fb', '<CMD>Telescope buffers<CR>' },
    { '<leader>fr', '<CMD>Telescope registers<CR>' },
    { '<leader>fp', '<CMD>Telescope oldfiles<CR>' },
  },
}

function M.config()
  require('telescope').setup({})
  require('which-key').register({
    ['<Leader>f'] = {
      name = '[f]ind',
      ['t'] = '[t]elescopes',
      ['b'] = '[b]uffer',
      ['f'] = '[f]ile',
      ['g'] = '[g]it',
      ['s'] = '[s]tring',
      ['r'] = '[r]egister',
      ['p'] = '[h]istory',
    },
  })
end

return M
