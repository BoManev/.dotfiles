local M = {}

M.setup = function()
    require("neodev").setup {
    -- library = {
    --   plugins = { "nvim-dap-ui" },
    --   types = true,
    -- },
  }
  local cmp = require('cmp')
  local cmp_lsp = require("cmp_nvim_lsp")
  local capabilities = vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    cmp_lsp.default_capabilities())
  require("fidget").setup({})
  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = {
      "lua_ls",
      "rust_analyzer",
      "tsserver",
      "pyright",
      "ruff_lsp",
      "typst_lsp"
    },
    handlers = {
      function(server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {
          capabilities = capabilities
        }
      end,
    }
  })

  cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    view = {
      entries = "native" -- can be "custom", "wildmenu" or "native"
    },
    mapping = cmp.mapping.preset.insert(require("vault.keys").cmp()),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, -- For luasnip users.
    }, {
        { name = 'buffer' },
      })
  })

end

M.select_formatter = function(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  local formatters = {}

  for _, c in pairs(clients) do
    if c.server_capabilities.documentFormattingProvider
    then
      table.insert(formatters, c.name)
    end
  end

  if #formatters > 1 then
    vim.ui.select(formatters, { prompt = "Select formatter" }, function(_, choice)
      if not choice then
        print("No selection")
        return
      end
      local formatter = formatters[choice]
      vim.lsp.buf.format({ async = true, name = formatter })
    end)
  else
    vim.lsp.buf.format({ async = true, name = formatters[1] })
  end
end

return M
