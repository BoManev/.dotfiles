return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'c',
          'lua',
          'cpp',
          'python',
          'javascript',
          'typescript',
          'regex',
          'vimdoc',
          'vim',
          'query',
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<leader>ot',
            node_incremental = '<leader>oo',
            scope_incremental = '<leader>os',
            node_decremental = '<leader>oi',
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- you can use the capture groups defined in textobjects.scm
              ['av'] = '@parameter.outer',
              ['iv'] = '@parameter.inner',
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              [']m'] = '@function.outer',
              [']]'] = '@class.outer',
            },
            goto_next_end = {
              [']m'] = '@function.outer',
              [']['] = '@class.outer',
            },
            goto_previous_start = {
              ['[m'] = '@function.outer',
              ['[['] = '@class.outer',
            },
            goto_previous_end = {
              ['[m'] = '@function.outer',
              ['[]'] = '@class.outer',
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>n'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>p'] = '@parameter.inner',
            },
          },
        },
      })
      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
      vim.opt.foldenable = false
      local wk = require('which-key')
      wk.register({
        ['<leader>o'] = {
          name = '[o]bjects',
          ['t'] = '[t]oggle',
          ['a'] = '[i]nner',
          ['o'] = '[o]outer',
          ['s'] = '[s]cope',
          ['n'] = 'swap [n]ext',
          ['p'] = 'swap [p]rev',
        },
      })
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
  },
  {
    'nvim-treesitter/playground',
    cmd = 'TSPlaygroundToggle',
  },
}

-- keybindings
--    r: refreshes the playground view when focused or reloads the query when the query editor is focused.
--    o: toggles the query editor when the playground is focused.
--    a: toggles visibility of anonymous nodes.
--    i: toggles visibility of highlight groups.
--    i: toggles visibility of the language the node belongs to.
--    t: toggles visibility of injected languages.
--    f: focuses the language tree under the cursor in the playground. the query editor will now be using the focused language.
--    f: unfocuses the currently focused language.
--    <cr>: go to current node in code buffer
