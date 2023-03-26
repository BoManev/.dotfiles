local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>t', '<CMD>Telescope<CR>', {})
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
vim.keymap.set('n', '<leaver>rf', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fk', builtin.keymaps, {})
vim.keymap.set('n', '<leader>fc', builtin.commands, {})
---             { '<leader>tl', '<CMD>Telescope<CR>',		mode = { 'n' } },
