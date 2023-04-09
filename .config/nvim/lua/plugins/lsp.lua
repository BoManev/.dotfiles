return {
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    cmd = 'Mason',
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup()
      require('mason-null-ls').setup({
        ensure_installed = { 'stylua' },
        automatic_installation = false,
        automatic_setup = true,
      })
    end,
    dependencies = {
      { 'williamboman/mason-lspconfig.nvim' },
      { 'jose-elias-alvarez/null-ls.nvim' },
      { 'jay-babu/mason-null-ls.nvim' },
    },
  },
  {
    'p00f/clangd_extensions.nvim',
    ft = { 'c', 'cpp', 'h', 'hpp' },
    config = function()
      require('clangd_extensions').setup({
        server = {
          on_attach = function(_, bufnr)
            require('keys').lsp_keys(bufnr)
          end,
        },
      })
    end,
  },
  {
    'folke/neodev.nvim',
    ft = { 'lua' },
    config = function()
      require('neodev').setup({})
      require('lspconfig').lua_ls.setup({
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
          },
        },
      })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    cmd = 'LspInfo',
    config = function()
      local lsp = require('lsp-zero')

      lsp.skip_server_setup({ 'clangd', 'lua_ls' })

      lsp.on_attach(function(_, bufnr)
        require('keys').lsp_keys(bufnr)
      end)

      lsp.format_mapping('gq', {
        format_opts = {
          async = false,
          timeout_ms = 10000,
        },
        servers = {
          ['null-ls'] = { 'lua', 'cpp', 'c' },
        },
      })

      lsp.setup()

      local null_ls = require('null-ls')

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.clang_format,
        },
      })
    end,
    dependencies = {
      { 'williamboman/mason.nvim' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/nvim-cmp' },
    },
  },
}
