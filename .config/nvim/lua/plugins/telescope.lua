local M = {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = 'Telescope',
}

function M.config()
    local builtin = require('telescope.builtin')

    vim.keymap.set('n', '<leader>t', '<CMD>Telescope<CR>', {})
    vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
    vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
    vim.keymap.set('n', '<leader>rf', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, {})
    vim.keymap.set('n', '<leader>fc', builtin.commands, {})
end

return M

--return {
--    'nvim-telescope/telescope.nvim', tag = '0.1.1',
--    dependencies = { 'nvim-lua/plenary.nvim' },
--    lazy = true,
--    keys = {
--        { '<leader>t', '<CMD>Telescope<CR>', mode = { 'n' } },
--        { '<leader>pf', '<CMD>Telescope find_files<CR>', mode = { 'n' } },
--        { '<leader>gf', '<CMD>Telescope git_files<CR>', mode =  {'n'}},
--        { '<leader>rf', '<CMD>Telescope live_grep<CR>', mode = { 'n' } },
--        { '<leader>fc', '<CMD>Telescope commands<CR>', mode = { 'n' } },
--        { '<leader>fk', '<CMD>Telescope keymaps<CR>', mode = { 'n' } },
--        { '<leader>fb', '<CMD>Telescope buffers<CR>', mode = { 'n' } },
--    }
--}
--
