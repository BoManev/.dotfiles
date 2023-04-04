local M = {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v2.x',
  dependencies = {
    -- LSP Support
    {'neovim/nvim-lspconfig'},
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},

    -- Autocompletion
    {'hrsh7th/nvim-cmp'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/cmp-buffer'},
    {'hrsh7th/cmp-path'},
    {'petertriho/cmp-git', dependencies = { 'nvim-lua/plenary.nvim' }},
    -- Snippets
    {'saadparwaiz1/cmp_luasnip'},
    {'L3MON4D3/LuaSnip'},

    -- UI
    {'onsails/lspkind.nvim'},

    -- Extras 
    {'p00f/clangd_extensions.nvim'},
    {'folke/neodev.nvim'}
  }
}

local function init_mason()
  require('mason').setup({
    ui = {
      border = 'rounded'
    }
  })
  require("mason-lspconfig").setup({
    ensure_installed = {
      "rust_analyzer",
      "clangd"
    }
  })
end

local function keybinds(bufnr)
  local opts = {buffer = bufnr, remap = false}
  vim.keymap.set("n", "<leader>lh", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>ld", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "<leader>lD", function() vim.lsp.buf.declaration() end, opts)
  vim.keymap.set("n", "<leader>li", function() vim.lsp.buf.implementation() end, opts)
  vim.keymap.set("n", "<leader>lt", function() vim.lsp.buf.type_definition() end, opts)
  vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.type_references() end, opts)
  vim.keymap.set("n", "<leader>ls", function() vim.lsp.buf.signature_help() end, opts)
  vim.keymap.set("n", "<leader>lR", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format() end, opts)
  vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>lx", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "<leader>ln", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "<leader>lp", function() vim.diagnostic.goto_prev() end, opts)
end

local function init_lsp()
  local lsp = require('lsp-zero').preset({})
  lsp.on_attach(function(_, bufnr)
    keybinds(bufnr)
  end)
  lsp.skip_server_setup({'clangd'})
  return lsp
end

local function init_cmd()
  local cmp = require('cmp')
  local cmp_action = require('lsp-zero').cmp_action()
  cmp.setup({
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    sources = {
      { name = 'nvim_lua' },

      { name = 'nvim_lsp' },
      { name = 'path' },
      { name = 'buffer', keyword_length = 5 },
      { name = 'luasnip', keyword_length = 2}
    },
    mapping = {
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-y>'] = cmp.mapping.confirm({ select = true }),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<C-p>'] = cmp.mapping.scroll_docs(-4),
      ['<C-n>'] = cmp.mapping.scroll_docs(4),
      ['<C-f>'] = cmp_action.luasnip_jump_forward(),
      ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    },
    formatting = {
      fields = {'abbr', 'kind', 'menu'},
      format = require('lspkind').cmp_format({
        mode = 'symbol_text',
        maxwidth = 50,
        ellipsis_char = '...',
      })
    },
    sorting = {
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.recently_used,
        require("clangd_extensions.cmp_scores"),
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },
  })

  -- extends sources using autos cmp.setup.buffer
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' },
    }, {
        { name = 'buffer' },
      })
  })
end

function M.config()
  init_mason()
  local lsp = init_lsp()

  require("clangd_extensions").setup({
    server = {
      on_attach = function(_, bufnr)
        keybinds(bufnr)
      end
    }
  })
  require('neodev').setup({})
  local lspconf = require('lspconfig')
  lspconf.lua_ls.setup({})
  --lspconf.lua_ls.setup(lsp.nvim_lua_ls())

  lsp.setup()
  init_cmd()
end

return M
