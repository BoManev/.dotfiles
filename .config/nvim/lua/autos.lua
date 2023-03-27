local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

vim.api.nvim_create_autocmd('FileType', {
    group = augroup('txtdoc'),
    pattern = { 'gitcommit', 'markdownr', 'norg' },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
        vim.opt_local.breakindent = true
        vim.opt_local.signcolumn = 'no'
  end
})

vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup('highlight_yank'),
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
        on_visual = false,
        higroup = 'IncSearch',
        timeout = 500
    })
  end,
})
