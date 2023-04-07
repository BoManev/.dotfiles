local M = {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  dependencies = {
    { 'nvim-treesitter/playground', event = 'VeryLazy', cmd = 'TSPlaygroundToggle' },
  },
}

function M.config()
  require('nvim-treesitter.configs').setup({
    ensure_installed = { 'c', 'lua', 'cpp', 'python', 'javascript', 'typescript', 'vim', 'help', 'query' },
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
    },
  })
end

return M

--Keybindings
--
--    R: Refreshes the playground view when focused or reloads the query when the query editor is focused.
--    o: Toggles the query editor when the playground is focused.
--    a: Toggles visibility of anonymous nodes.
--    i: Toggles visibility of highlight groups.
--    I: Toggles visibility of the language the node belongs to.
--    t: Toggles visibility of injected languages.
--    f: Focuses the language tree under the cursor in the playground. The query editor will now be using the focused language.
--    F: Unfocuses the currently focused language.
--    <cr>: Go to current node in code buffer
