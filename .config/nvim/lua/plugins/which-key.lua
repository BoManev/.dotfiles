local M = {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  priority = 1,
  keys = {
    { 'g?', '<CMD>WhichKey<CR>', mode = { 'n', 'v' } },
    { '<C-g>?', '<CMD>WhichKey<CR>', mode = { 'i' } },
  },
}
local nmode = {
  ['<Leader>f'] = {
    name = '[f]ind',
    ['t'] = '[t]elescope',
    ['b'] = '[b]uffer',
    ['f'] = '[f]ile',
    ['g'] = '[g]it',
    ['s'] = '[s]tring',
    ['r'] = '[r]egister',
    ['p'] = '[p]reviou',
  },
  ['<Leader>d'] = {
    name = '[d]iagnostics',
    ['t'] = '[t]oggle',
    ['w'] = '[w]orkspace',
    ['c'] = '[c]urrent',
    ['l'] = '[l]ocations',
    ['q'] = '[q]uickfix',
    ['r'] = '[r]eferences',
  },
  ['<Leader>e'] = '[e]xplorer',
  ['<Leader>w'] = {
    name = '[w]iki',
    ['s'] = '[s]earch',
    ['l'] = '[l]ink',
    ['c'] = '[c]onceal',
    ['r'] = '[r]eturn',
    ['i'] = '[i]ndex',
    ['e'] = '[e]xport',
    ['j'] = '[j]ournal',
  },
  ['<Leader>l'] = {
    name = '[l]sp',
    ['h'] = '[h]over',
    ['d'] = '[d]efinition',
    ['D'] = '[D]eclaration',
    ['i'] = '[i]mplementation',
    ['t'] = '[t]ype',
    ['r'] = '[r]eferences',
    ['s'] = '[s]ignature',
    ['R'] = '[R]ename',
    ['f'] = '[f]ormat',
    ['a'] = '[a]ction',
    ['x'] = 'diagnostics',
    ['[d'] = 'previous x',
    [']d'] = 'previous x',
  },
}
function M.config()
  local wk = require('which-key')
  wk.setup({
    plugins = {
      mark = false,
      registers = false,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = true, -- adds help for operators like d, y, ...
        motions = true, -- adds help for motions
        text_objects = true, -- help for text objects triggered after entering an operator
        windows = true, -- default bindings on <c-w>
        nav = true, -- misc bindings to work with windows
        z = true, -- bindings for folds, spelling and others prefixed with z
        g = true, -- bindings for prefixed with g
      },
    },
    motions = {
      count = true,
    },
    icons = {
      breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
      separator = '➜', -- symbol used between a key and it's label
      group = '+', -- symbol prepended to a group
    },
    popup_mappings = {
      scroll_down = '<c-d>', -- binding to scroll down inside the popup
      scroll_up = '<c-u>', -- binding to scroll up inside the popup
    },
    window = {
      border = 'none', -- none, single, double, shadow
      position = 'bottom', -- bottom, top
      margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
      padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
      winblend = 30, -- value between 0-100 0 for fully opaque and 100 for fully transparent
    },
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
      align = 'left', -- align columns left, center or right
    },
    ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
    hidden = { '<silent>', '<cmd>', '<Cmd>', '<CR>', '^:', '^ ', '^call ', '^lua ' }, -- hide mapping boilerplate
    show_help = true, -- show a help message in the command line for using WhichKey
    show_keys = true, -- show the currently pressed key and its label as a message in the command line
    triggers = 'auto', -- automatically setup triggers
    -- list of triggers, where WhichKey should not wait for timeoutlen and show immediately
    triggers_nowait = {
      -- marks
      '`',
      '\'',
      'g`',
      'g\'',
      -- spelling
      'z=',
    },
    triggers_blacklist = {
      i = { 'j', 'k' },
      v = { 'j', 'k' },
    },
    disable = {
      buftypes = {},
      filetypes = {},
    },
  })

  require('which-key').register(nmode, { mode = 'n' })
  --require('which-key').register(require('plugins.which-key.imode'), { mode = 'i' })
  --wk.register(require("core.plugins.utility.which-key.motions"), { mode = "o" })
  --wk.register(require("core.plugins.utility.which-key.insert-mode"), { mode = "i" })
end

return M
