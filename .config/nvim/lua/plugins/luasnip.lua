local M = {
  'L3MON4D3/LuaSnip',
  version = '1.*',
  build = 'make install_jsregexp',
  dependencies = {
    'rafamadriz/friendly-snippets',
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
    end,
  },
}

M.config = function()
  local ls = require('luasnip')
  local types = require('luasnip.util.types')
  ls.setup({
    history = true,
    update_events = 'TextChanged,TextChangedI',
    delete_check_events = 'TextChanged',
    ext_opts = {
      [types.choiceNode] = {
        active = {
          virt_text = { { 'choiceNode', 'Comment' } },
        },
      },
    },
    ext_base_prio = 300,
    ext_prio_increase = 1,
    enable_autosnippets = true,
    store_selection_keys = '<Tab>',
    ft_func = require('luasnip.extras.filetype_functions').from_cursor,
  })
end
return M
