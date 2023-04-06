local tnight = {
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000,
  opts = { style = 'moon' },
  config = function()
    vim.cmd([[colorscheme tokyonight]])
    vim.o.background = 'dark'
  end,
}

local kanagawa = {
  'rebelot/kanagawa.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    theme = 'wave',
    background = { 'dragon' },
  },
  config = function()
    vim.cmd([[colorscheme kanagawa]])
    vim.o.background = 'dark'
  end,
}

return kanagawa
