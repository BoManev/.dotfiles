local M = {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'petertriho/cmp-git', dependencies = { 'nvim-lua/plenary.nvim' } },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'onsails/lspkind.nvim' },
    { 'hrsh7th/cmp-cmdline' },
    { 'L3MON4D3/LuaSnip' },
    {'p00f/clangd_extensions.nvim'},
  },
}
function M.config()
  require('lsp-zero.cmp').extend()
  local icons = require('icons')
  local cmp = require('cmp')
  local compare = require('cmp.config.compare')
  local cmp_action = require('lsp-zero').cmp_action()
  cmp.setup({
    completion = {
      completeopt = 'menu,menuone,noinsert',
    },
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = {
      ['<C-f>'] = cmp_action.luasnip_jump_forward(),
      ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    sources = {
      { name = 'nvim_lua' },
      { name = 'nvim_lsp' },
      { name = 'path' },
      { name = 'buffer', keyword_length = 5 },
      { name = 'luasnip', keyword_length = 2 },
      { name = 'git' },
    },
    formatting = {
      fields = { 'kind', 'abbr', 'menu' },
      format = function(entry, item)
        local max_width = 0
        local source_names = {
          nvim_lsp = '(LSP)',
          path = '(Path)',
          luasnip = '(Snippet)',
          buffer = '(Buffer)',
        }
        local duplicates = {
          buffer = 1,
          path = 1,
          nvim_lsp = 0,
          luasnip = 1,
        }
        local duplicates_default = 0
        if max_width ~= 0 and #item.abbr > max_width then
          item.abbr = string.sub(item.abbr, 1, max_width - 1) .. icons.ui.Ellipsis
        end
        item.kind = icons.kind[item.kind]
        item.menu = source_names[entry.source.name]
        item.dup = duplicates[entry.source.name] or duplicates_default
        return item
      end,
    },
    sorting = {
      comparators = {
        compare.score,
        compare.recently_used,
        compare.offset,
        compare.exact,
        require("clangd_extensions.cmp_scores"),
        compare.kind,
        compare.sort_text,
        compare.length,
        compare.order,
      },
    },
  })

  -- extends sources using autos cmp.setup.buffer
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' },
    },
  })
end

return M
