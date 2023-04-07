
-- run something and capture the input
local bufnr = 5
vim.api.nvim_create_autocmd('BufWritePost', {
  group = vim.api.nvim_create_augroup('Test', { clear = true }),
  pattern = '*.lua',
  callback = function()
    vim.fn.jobstart({ 'echo', 'test' }, {
      stdout_buffered = true,
      on_stdout = function(_, data)
        if data then
          vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
        end
      end,
    })
  end,
})
