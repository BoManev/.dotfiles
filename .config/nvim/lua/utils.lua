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

function M.smart_insert()
  if #vim.fn.getline('.') == 0 then
    return [["_cc]]
  else
    return 'i'
  end
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

-- Show a simple popup with some basic file information
function M.file_info()
  local filename = vim.fn
    .expand('%')
    :gsub(vim.pesc(vim.loop.cwd()), '.')
    :gsub(vim.pesc(vim.fn.expand('$HOME')), '~')

  local type = vim.bo.ft
  local branch = vim.b.gitsigns_head
  local lsp_client_names = table.concat(
    vim.tbl_map(function(client)
      return client.name
    end, vim.tbl_values(vim.lsp.buf_get_clients(0))),
    ', '
  )

  -- Each line consists of a label and a text.
  local lines = { { 'name', filename } }
  if #type > 1 then
    table.insert(lines, { 'type', type })
  end
  if branch then
    table.insert(lines, { 'branch', branch })
  end
  if #lsp_client_names > 1 then
    table.insert(lines, { 'lsp', lsp_client_names })
  end

  local label_lengths = vim.tbl_map(function(line)
    return #line[1]
  end, lines)
  local max_label_length = math.max(unpack(label_lengths))

  -- Pad labels of lines and convert each line to a string
  local lines_texts = vim.tbl_map(function(line)
    local label = line[1]
    local text = line[2]

    local padding = ''
    local nr_of_spaces_to_add = max_label_length - #label
    for i = 1, nr_of_spaces_to_add do
      padding = padding .. ' '
    end

    return label .. ': ' .. padding .. text
  end, lines)

  vim.notify(table.concat(lines_texts, '\n'), vim.log.levels.INFO, {
    title = 'File info',
  })
end

return M
