local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

-- change formating for documants
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('txtdoc'),
  pattern = { 'gitcommit', 'markdown', 'norg' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt_local.breakindent = true
    vim.opt_local.signcolumn = 'no'
  end,
})

-- highlight on yank
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

-- open pdfs with zathura
vim.api.nvim_create_autocmd('BufEnter', {
  group = augroup('pdf'),
  pattern = { '*.pdf' },
  callback = function()
    vim.api.nvim_command([[execute "!zathura '%' &"| bdelete % | :E]])
  end,
})

-- toggle between relative and absolute numbers
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

-- open buffer without folds
vim.api.nvim_create_autocmd({ 'BufReadPost', 'FileReadPost' }, {
  pattern = '*',
  callback = function()
    if vim.bo.filetype == 'norg' then
      return
    end
    vim.cmd('normal zR')
  end,
  group = augroup('open_folds'),
})

-- disable auto comments (set by builtin ftplugin)
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = '*',
  callback = function()
    vim.o.formatoptions = 'tcqj'
    vim.opt.formatoptions = vim.opt.formatoptions
      - 'a' -- don't format
      - 't' -- don't auto format
      + 'c' -- respect textwidth
      + 'q' -- format with gq
      - 'o' -- don't continue comment after O and o,
      + 'r' -- continue with comment after enter.
      + 'n' -- respect numbered
      + 'j' -- auto remove
      - '2' -- no paragraph indent
  end,
  group = augroup('no_auto_comments'),
})

-- change formating for plugins
vim.api.nvim_create_autocmd('BufEnter', {
  group = augroup('plugdoc'),
  pattern = { 'lazy', 'mason', 'help', 'checkhealth', 'netrw' },
  callback = function()
    vim.opt_local.signcolumn = 'no'
  end,
})

