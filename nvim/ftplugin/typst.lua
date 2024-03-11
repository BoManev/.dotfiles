M = {}
M.typst_watcher = function()
  vim.api.nvim_command('vsp')
  vim.api.nvim_command('vertical resize 20')
  local current_file = vim.fn.expand("%:")
  vim.api.nvim_command('terminal typst watch ' .. current_file)
  vim.api.nvim_command('normal \\<c-w>h')
end

-- Map <leader>fc to call TypstWatch()
vim.keymap.set('n', '<leader>tc', function() M.typst_watcher() end, { noremap = true, silent = true })

-- Map <leader>fr to execute zathura command
vim.keymap.set('n', '<leader>tr', ':silent exec "!zathura --fork " .. vim.fn.expand("%:p:r") .. ".pdf &"<CR>',
  { noremap = true, silent = true })
