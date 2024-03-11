local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

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

-- change formating for documents
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

-- Remove trailing whitespaces on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup('0strip-whitespace'),
  pattern = "*",
  callback = function(_ev)
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = augroup("lsp_keys"),
  callback = function(e)
    local opts = { buffer = e.buf }
    require("vault.keys").lsp(opts)
  end
})
