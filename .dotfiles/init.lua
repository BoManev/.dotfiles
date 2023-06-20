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

vnoremap <C-c> "*y
