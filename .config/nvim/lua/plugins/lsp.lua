local M = {
  'neovim/nvim-lspconfig',
  cmd = 'LspInfo',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'williamboman/mason-lspconfig.nvim' },
    {'VonHeikemen/lsp-zero.nvim'},
    {
      'williamboman/mason.nvim',
      build = ':MasonUpdate',
    },
    { 'jose-elias-alvarez/null-ls.nvim' },
    {
      'jay-babu/mason-null-ls.nvim',
      dependencies = {
        'williamboman/mason.nvim',
        'jose-elias-alvarez/null-ls.nvim',
      },
    },
    { 'p00f/clangd_extensions.nvim' },
    { 'folke/neodev.nvim' },
  },
}
local function attached(bufnr)
  local opts = { buffer = bufnr, remap = false }
  vim.keymap.set('n', '<leader>lh', function()
    vim.lsp.buf.hover()
  end, opts)
  vim.keymap.set('n', '<leader>ld', function()
    vim.lsp.buf.definition()
  end, opts)
  vim.keymap.set('n', '<leader>lD', function()
    vim.lsp.buf.declaration()
  end, opts)
  vim.keymap.set('n', '<leader>li', function()
    vim.lsp.buf.implementation()
  end, opts)
  vim.keymap.set('n', '<leader>lt', function()
    vim.lsp.buf.type_definition()
  end, opts)
  vim.keymap.set('n', '<leader>lr', function()
    vim.lsp.buf.references()
  end, opts)
  vim.keymap.set('n', '<leader>ls', function()
    vim.lsp.buf.signature_help()
  end, opts)
  vim.keymap.set('n', '<leader>lR', function()
    vim.lsp.buf.rename()
  end, opts)
  vim.keymap.set('n', '<leader>lf', function()
    vim.lsp.buf.format()
  end, opts)
  vim.keymap.set('n', '<leader>la', function()
    vim.lsp.buf.code_action()
  end, opts)
  vim.keymap.set('n', '<leader>lx', function()
    vim.diagnostic.open_float()
  end, opts)
  vim.keymap.set('n', '<leader>ln', function()
    vim.diagnostic.goto_next()
  end, opts)
  vim.keymap.set('n', '<leader>lp', function()
    vim.diagnostic.goto_prev({})
  end, opts)
end

function M.config()
  local lsp = require('lsp-zero')
  lsp.on_attach(function(_, bufnr)
    attached(bufnr)
  end)

  lsp.skip_server_setup({ 'clangd', 'lua_ls' })
  lsp.setup()

  local lspconfig = require('lspconfig')

  require('neodev').setup({})
  lspconfig.lua_ls.setup({
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
      },
    },
  })
  require('clangd_extensions').setup({
    server = {
      on_attach = function(_, bufnr)
        attached(bufnr)
      end,
    },
  })

  local null_ls = require('null-ls')
  local null_opts = lsp.build_options('null-ls', {})
  null_ls.setup({
    debug = true,
    on_attach = function(client, bufnr)
      null_opts.on_attach()
    end,
    sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.clang_format,
    },
  })

  require('mason-null-ls').setup({
    ensure_installed = nil,
    automatic_installation = false;
    automatic_setup = true,
  })

  require('mason-null-ls').setup_handlers()
  lsp.format_mapping('gq', {
    format_opts = {
      async = false,
      timeout_ms = 10000,
    },
    servers = {
      ['null-ls'] = { 'lua', 'cpp', 'c' },
    },
  })
end

return M
