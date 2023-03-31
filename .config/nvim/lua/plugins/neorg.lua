local M = {
  'nvim-neorg/neorg',
  build = ':Neorg sync-parsers',
  cmd = {'Neorg'},
  ft = {'norg'},
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-neorg/neorg-telescope' }
  },
  keys = {
    { '<Leader>wc',
      function()
        if vim.bo.filetype == 'norg' then
          require('neorg').modules.get_module('core.norg.concealer').toggle_concealer()
        end
      end
    },
    { '<Leader>wj', '<CMD>Neorg journal today<CR>' },
    { '<Leader>we',
      function()
        if vim.bo.filetype == 'norg' then
          vim.cmd.Neorg('export')
        end
      end,
    },
    { '<Leader>wi', '<CMD>Neorg index<CR>' },
    { '<Leader>wr', '<CMD>Neorg return<CR>' },
  }
}
function M.config()
  require('neorg').setup({
    load = {
      ["core.defaults"] = {},
      ['core.norg.concealer'] = {
        config = {
          icon_preset = 'diamond'
        }
      },
      ['core.norg.dirman'] = {
        config = {
          workspaces = {
            vault = '~/bohq/vault',
          },
          default_workspace = "vault"
        },
      },
      ['core.export'] = {},
      ['core.export.markdown'] = {},
    }
  })

  end

return M
