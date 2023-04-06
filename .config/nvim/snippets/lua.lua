local ls = require('luasnip')


local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local f = ls.function_node
local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep

local same = function(index)
  return f(function(arg)
    return arg[1]
  end, {index})
end

return {
  s('req',
    fmt([[local {} = require '{}']], { f(function(import_name)
      return import_name[1]
    end, { 1 }), i(1)})
  ),
}
