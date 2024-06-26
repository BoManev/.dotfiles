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

function M.contains(table, value)
  for _, v in ipairs(table) do
    if v == value then
      return true
    end
  end
  return false
end

function M.smart_dd()
  if vim.api.nvim_get_current_line():match('^%s*$') then
    return '"_dd'
  else
    return 'dd'
  end
end

function M.debug_print(...)
  local objects = vim.tbl_map(vim.inspect, { ... })
  return print(unpack(objects))
end

function M.open_url()
  local uri = vim.fn.expand('<cWORD>')
  -- [test](https://google.com)
  uri = uri:match('[a-z]*://[^ >,;)]*') or uri
  uri = uri:gsub('?', '\\?', 1)
  uri = vim.fn.shellescape(uri, 1)
  if uri ~= '' then
    vim.fn.execute("!open '" .. uri .. "'")
    vim.cmd.redraw()
  end
end

function M.open_file()
  vim.fn.system('open ' .. vim.fn.expand('%:p'))
  vim.cmd([[buffer#]])
  vim.cmd([[bdelete#]])
  vim.cmd([[redraw!]])
end

return M
