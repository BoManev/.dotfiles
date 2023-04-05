local opts = {buffer = bufnr, remap = false}
vim.keymap.set('n', '<leader>e', vim.cmd.Ex, opts)
vim.keymap.set('n', 'z?', function() vim.opt.spell = true end, opts)

vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set('n', '<leader>ss', '<cmd> source ~./config/nvim/')
