local M = {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'petertriho/cmp-git', dependencies = { 'nvim-lua/plenary.nvim' } },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'onsails/lspkind.nvim' },
    { 'hrsh7th/cmp-cmdline' },
    { 'L3MON4D3/LuaSnip' },
    { 'onsails/lspkind.nvim' },
  },
--   opts = function(_, opts)
--    for _, source in ipairs(opts.sources) do
--      if source.name == "luasnip" then
--        source.option = { use_show_condition = true }
--        source.entry_filter = function()
--          local context = require("cmp.config.context")
--          local string_ctx = context.in_treesitter_capture("string") or context.in_syntax_group("String")
--          local comment_ctx = context.in_treesitter_capture("comment") or context.in_syntax_group("Comment")
--
--          -- Returning `true` will keep the entry, while returning `false` will remove it.
--          return not string_ctx and not comment_ctx
--        end
--      end
--    end
--   end,
}

function M.config()
  require('lsp-zero.cmp').extend()
  local cmp = require('cmp')
  local compare = require('cmp.config.compare')
  local cmp_action = require('lsp-zero.cmp').action()
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
    sorting = {
      comparators = {
        compare.score,
        compare.recently_used,
        compare.offset,
        compare.exact,
        require('clangd_extensions.cmp_scores'),
        compare.kind,
        compare.sort_text,
        compare.length,
        compare.order,
      },
    },
    formatting = {
      fields = { 'abbr', 'kind', 'menu' },
      format = require('lspkind').cmp_format({
        mode = 'symbol',
        maxwidth = 50,
        ellipsis_char = '...',
      }),
    },
  })

  --i extends sources using autos cmp.setup.buffer
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' },
    },
  })
  -- `:` cmdline setup.
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' },
    }, {
      {
        name = 'cmdline',
        option = {
          ignore_cmds = { 'Man', '!' },
        },
      },
    }),
  })
end

return M
