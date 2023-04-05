local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local function copy(args)
	return args[1]
end

ls.add_snippets('all', {
  s("fn", {
    -- Simple static text.
    t("//Parameters: "),
    -- function, first parameter is the function, second the Placeholders
    -- whose text it gets as input.
    f(copy, 2),
    t({ "", "function " }),
    -- Placeholder/Insert.
    i(1),
    t("("),
    -- Placeholder with initial text.
    i(2, "int foo"),
    -- Linebreak
    t({ ") {", "\t" }),
    -- Last Placeholder, exit Point of the snippet.
    i(0),
    t({ "", "}" }),
  }),
})
