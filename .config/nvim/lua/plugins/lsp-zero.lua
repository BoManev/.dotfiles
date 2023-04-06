return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v2.x',
  lazy = true,
  config = function()
    local lsp = require('lsp-zero.settings').preset({})
  end,
}
--    lsp.skip_server_setup({'clangd'})
--  require("clangd_extensions").setup({
--    server = {
--      on_attach = function(_, bufnr)
--        keybinds(bufnr)
--      end
--    }
--  })
--
