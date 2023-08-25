return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v2.x',
  lazy = true,
  config = function()
    require('lsp-zero.settings').preset({
      float_border = 'rounded',
      call_servers = 'local',
      configure_diagnostics = true,
      setup_servers_on_start = true,
      set_lsp_keymaps = false,
      manage_nvim_cmp = {
        set_sources = false,
        set_basic_mappings = true,
        set_extra_mappings = true,
        use_luasnip = true,
        set_format = true,
        documentation_window = true,
      },
    })
  end,
}
