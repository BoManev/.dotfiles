local M = {}

function M.toggle_opt(prop, scope, on, off)
  return function()
    if vim[scope][prop] == on then
      vim[scope][prop] = off
    else
      vim[scope][prop] = on
    end
  end
end

function M.auto_from_cmd(definitions)
  for group_name, definition in pairs(definitions) do
    vim.api.nvim_command('augroup ' .. group_name)
    vim.api.nvim_command('autocmd!')
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten({ 'autocmd', def }), ' ')
      vim.api.nvim_command(command)
    end
    vim.api.nvim_command('augroup END')
  end
end

return M
