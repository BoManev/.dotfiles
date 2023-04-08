local M = {}

function M.toggle_opt(prop, scope, on, off)
    return function()
    if vim[scope][prop] == on then
      vim[scope][prop] = off
    else
      vim[scope][prop] = on
    end
--  local getter = nil
--  local setter = nil;
--  if buf then
--    getter = vim.api.nvim_buf_get_option
--    setter = vim.api.nvim_buf_set_option
--  else
--    getter = vim.api.nvim_win_get_option
--    setter = vim.api.nvim_win_set_option
--  end
--  return function()
--    if getter(0, prop) == on then
--      setter(0, prop, off)
--    else
--      setter(0, prop, on)
--    end
  end
end

return M
