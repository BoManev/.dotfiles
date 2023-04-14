return {
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    cmd = 'Mason',
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup()
      require('mason-null-ls').setup({
        ensure_installed = nil,
        automatic_installation = false,
        handlers = {},
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
    lazy = true,
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
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lsp = require('lsp-zero')
      local utils = require('utils')
      lsp.on_attach(function(_, bufnr)
        require('keys').lsp_keys(bufnr)
      end)

      lsp.skip_server_setup({ 'clangd', 'lua_ls' })

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

      require('clangd_extensions').setup({
        server = {
          on_attach = function(_, bufnr)
            require('keys').lsp_keys(bufnr)
          end,
          cmd = {
            'clangd',
            '--all-scopes-completion',
            '--suggest-missing-includes',
            '--header-insertion-decorators',
            '--background-index',
            '--pch-storage=disk',
            '--cross-file-rename',
            '--log=info',
            '--completion-style=detailed',
            '--enable-config',
            '--clang-tidy',
            '--offset-encoding=utf-16',
          },
        },
      })

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
    },
  },
}
