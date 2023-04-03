local M = {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {'williamboman/mason.nvim'},           -- Optional
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},     -- Required
      {'hrsh7th/cmp-nvim-lsp'}, -- Required
      {'L3MON4D3/LuaSnip'},     -- Required

      -- Extras 
      {'p00f/clangd_extensions.nvim'}
    }
}

function M.config()
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

    local lsp = require('lsp-zero').preset({
        manage_nvim_cmp = {
            set_sources = 'recommended'
        }
    })
    local attached = lsp.on_attach(function(_, bufnr)
        lsp.default_keymaps({buffer = bufnr})
    end)
    require("clangd_extensions").setup({
      server = {
        on_attach = attached

      }
    })
    local lspconf = require('lspconfig')
    lspconf.lua_ls.setup(lsp.nvim_lua_ls())

    lsp.setup()
    local cmp = require('cmp')
    cmp.setup({
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      sources = {
        {name = 'nvim_lsp'},
        {name = 'nvim_lua'},
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

end

return M
