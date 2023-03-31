local M = {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  keys = {
    { 'g?', '<CMD>WhichKey<CR>', mode = { 'n', 'v'} },
    { '<C-g>?', '<CMD>WhichKey<CR>', mode = { 'i' } },
  },

}

function M.config()
  local wk = require('which-key')
  wk.setup({
    plugins = {
      spelling = {
        enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
        suggestions = 20, -- how many suggestions should be shown in the list?
      },
      presets = {
        operators = true, -- adds help for operators like d, y, ...
        motions = true, -- adds help for motions
        text_objects = true, -- help for text objects triggered after entering an operator
        windows = false, -- default bindings on <c-w>
        nav = false, -- misc bindings to work with windows
        z = true, -- bindings for folds, spelling and others prefixed with z
        g = true, -- bindings for prefixed with g
      },
    },
    operators = {
      ["d"] = "Delete",
      ["c"] = "Change",
      ["v"] = "Visual character",
      ["y"] = "Yank",
      ["g~"] = "Toggle case",
      ["gc"] = "Toggle comment",
      ["gu"] = "Make lowercase",
      ["gU"] = "Make uppercase",
      ["<LT>"] = "De-indent",
      [">"] = "Indent",
      ["zf"] = "Create fold",
    },
    key_labels = {
      -- override the label used to display some keys. It doesn't effect WK in any other way.
      -- For example:
      -- ["<space>"] = "SPC",
      -- ["<cr>"] = "RET",
      -- ["<tab>"] = "TAB",
    },
    motions = {
      count = true,
    },
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "➜", -- symbol used between a key and it's label
      group = "+", -- symbol prepended to a group
    },
    popup_mappings = {
      scroll_down = "<c-d>", -- binding to scroll down inside the popup
      scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    window = {
      border = "none", -- none, single, double, shadow
      position = "bottom", -- bottom, top
      margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
      padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
      winblend = 0, -- value between 0-100 0 for fully opaque and 100 for fully transparent
    },
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
      align = "left", -- align columns left, center or right
    },
    ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "^:", "^ ", "^call ", "^lua " }, -- hide mapping boilerplate
    show_help = true, -- show a help message in the command line for using WhichKey
    show_keys = true, -- show the currently pressed key and its label as a message in the command line
    triggers = "auto", -- automatically setup triggers
    -- list of triggers, where WhichKey should not wait for timeoutlen and show immediately
    triggers_nowait = {
      -- marks
      "`",
      "'",
      "g`",
      "g'",
      -- registers
      '"',
      "<c-r>",
      -- spelling
      "z=",
    },
    triggers_blacklist = {
      i = { "j", "k" },
      v = { "j", "k" },
    },
    disable = {
      buftypes = {},
      filetypes = {},
    },
  })

  require('which-key').register(require('plugins.which-key.nmode'), { mode = 'n' })
  require('which-key').register(require('plugins.which-key.imode'), { mode = 'i' })
  --wk.register(require("core.plugins.utility.which-key.motions"), { mode = "o" })
  --wk.register(require("core.plugins.utility.which-key.insert-mode"), { mode = "i" })

end

return M
