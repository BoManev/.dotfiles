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
    local cmp = require('cmp')

    cmp.setup({
          window = {
              completion = cmp.config.window.bordered(),
              documentation = cmp.config.window.bordered(),
          },
          sources = {
              {name = 'nvim_lsp'},
              {name = 'nvim_lua'},
        }
    })
    lsp.on_attach(function(_, bufnr)
        lsp.default_keymaps({buffer = bufnr})
    end)

    require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

    lsp.setup()
end

return M
