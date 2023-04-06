local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

vim.api.nvim_create_autocmd('FileType', {
  group = augroup('txtdoc'),
  pattern = { 'gitcommit', 'markdown', 'norg' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt_local.breakindent = true
    vim.opt_local.signcolumn = 'no'
    -- rebuild spell file
    -- :mkspell! ~/.config/nvim/spell/en.utf-8.add.spl ~/.config/nvim/spell/en.utf-8.add
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup('highlight_yank'),
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      on_visual = false,
      higroup = 'IncSearch',
      timeout = 500,
    })
  end,
})

vim.api.nvim_create_autocmd('BufEnter', {
  group = augroup('pdf'),
  pattern = { '*.pdf' },
  callback = function()
    vim.api.nvim_command([[execute "!zathura '%' &"| bdelete % | :E]])
  end,
})

local numbertogglegroup = augroup('numbertoggle')
vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave' }, {
  pattern = '*',
  callback = function()
    vim.wo.relativenumber = true
  end,
  group = numbertogglegroup,
})
vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter' }, {
  pattern = '*',
  callback = function()
    vim.wo.relativenumber = false
  end,
  group = numbertogglegroup,
})
