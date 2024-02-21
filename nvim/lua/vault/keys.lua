local M = {}

M.mandatories = function()
  M.overwrite()
  M.buffer()
  M.tab()
  M.visual()
  M.explore()
  M.search()
  M.copy()
  M.toggle()
  M.misc()
end

-- ================== EDITOR ==================
M.overwrite = function()
  local utils = require('vault.core.utils')

  -- stop "@q"
  vim.keymap.set("n", "Q", "<nop>")

  -- don't copy emptry lines
  vim.keymap.set('n', 'dd', utils.smart_dd, { expr = true, silent = true })

  -- don't save to register
  vim.keymap.set('n', 'x', '"_x')

  -- move/center
  vim.keymap.set("n", "<C-d>", "<C-d>zz")
  vim.keymap.set("n", "<C-u>", "<C-u>zz")

  -- mark/join/goto mark
  vim.keymap.set("n", "J", "mzJ`z")

  -- i -> n
  vim.keymap.set("i", "<C-c>", "<Esc>")

  -- TODO: for markdown and text files only
  -- movement with wrapped lines
  -- vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
  -- vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
end

M.buffer = function()
  -- open last buffer
  vim.keymap.set('n', '<leader>bl', ':buffer #<CR>')

  -- previous buffer
  vim.keymap.set('n', '[b', ':bprevious<CR>')

  -- next buffer
  vim.keymap.set('n', ']b', ':bnext<CR>')

  -- close buffer
  vim.keymap.set('n', '<leader>bq', ':bdelete<CR>')
end

M.tab = function()
  -- previous tab
  vim.keymap.set('n', '[t', ':tprevious<CR>')

  -- next tab
  vim.keymap.set('n', ']t', ':tnext<CR>')

  -- Open new tabpage
  vim.keymap.set('n', '<Leader>tn', ':tabnew<CR>')
end


M.visual = function()
  -- indent without exit
  vim.keymap.set('v', '<', '<gv')
  vim.keymap.set('v', '>', '>gv')

  -- move down and indent
  vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

  -- move up and indent
  vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
end

M.explore = function()
  -- open parent directory
  vim.keymap.set(
    'n',
    '-',
    [[expand('%') == '' ? ':e ' . getcwd() . '<cr>' : ':e %:h<cr>']],
    { expr = true, silent = true }
  )

  -- open file explorer
  vim.keymap.set('n', '<leader>e', vim.cmd.Ex)

  -- open url at cursor
  vim.keymap.set('n', 'gx', require("vault.core.utils").open_url, { expr = true, silent = true })
end

M.search = function()
  -- jump/center/open fold
  vim.keymap.set("n", "n", "nzzzv")
  vim.keymap.set("n", "N", "Nzzzv")
end

M.refactor = function()
  -- replace all under cursor
  vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

  -- confirm replace all under cursor
  vim.keymap.set("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gIc<Left><Left><Left>]])
end

M.copy = function()
  -- yank to clipboard
  vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
  vim.keymap.set("n", "<leader>Y", [["+Y]])

  -- delete/paste
  vim.keymap.set("x", "<leader>p", [["_dP]])
  vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
end

M.toggle = function()
  -- toggle spell
  vim.keymap.set('n', '<leader>ts', function()
    require("vault.core.utils").toggle_opt("spell", "o", true, false)()
  end)

  -- toggle line column
  vim.keymap.set('n', '<leader>tcc', function()
    require("vault.core.utils").toggle_opt("colorcolumn", "wo", "81", "0")()
  end)

  -- toggle diagnostics
  vim.keymap.set('n', '<leader>td', function()
    local context = require("vault.core.context")
    local state = context.diagnostics_active
    context.diagnostics_active = not state
    if state then
      vim.diagnostic.show()
    else
      vim.diagnostic.hide()
    end
  end)
end

M.misc = function()
  -- make executable
  vim.keymap.set("n", "<leader>cx", "<cmd>!chmod +x %<CR>", { silent = true })

  -- source lua file
  vim.keymap.set("n", "<leader>so", function()
    vim.cmd("so")
  end)
end

M.lsp = function(opts)
  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
  vim.keymap.set('n', 'gI', function() vim.lsp.buf.implementation() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set('n', '<leader>la', function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>lR", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set('n', '<leader>lf', require("vault.plugins.lsp.utils").select_formatter, opts)
  vim.keymap.set("n", "<leader>lws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>ls", function() vim.lsp.buf.signature_help() end, opts)
  vim.keymap.set('n', '<leader>lt', function() vim.lsp.buf.type_definition() end, opts)
  vim.keymap.set("n", "<leader>ld", function() vim.diagnostic.open_float({focusable = true }) end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
end

-- ================== PLUGINS ==================
M.telescope = function()
  local builtin = require('telescope.builtin')
  vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
  vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
  vim.keymap.set('n', '<leader>fw', function()
    local word = vim.fn.expand("<cword>")
    builtin.grep_string({ search = word })
  end)
  vim.keymap.set('n', '<leader>fW', function()
    local word = vim.fn.expand("<cWORD>")
    builtin.grep_string({ search = word })
  end)
  vim.keymap.set('n', '<leader>fs', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
  end)
  vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
end

M.undotree = function()
  vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
end

M.trouble = function()
  local trouble = require("trouble")
  vim.keymap.set("n", "<leader>te", function()
    trouble.toggle()
  end)

  vim.keymap.set("n", "[e", function()
    trouble.next({ skip_groups = true, jump = true });
  end)

  vim.keymap.set("n", "]e", function()
    trouble.previous({ skip_groups = true, jump = true });
  end)
end

M.treesitter = function()
  return {
    init_selection = '<leader>oo',
    node_incremental = '<leader>oi',
    node_decremental = '<leader>od',
    scope_incremental = '<leader>os',
  }
end

M.cmp = function()
  local cmp = require('cmp')
  local cmp_select = { behavior = cmp.SelectBehavior.Select }
  return {
    ['<C-g>'] = cmp.mapping(cmp.mapping.open_docs()),
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
		['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
  }
end

M.snippets = function()
  local ls = require("luasnip")

  --- TODO: What is expand?
  vim.keymap.set({ "i" }, "<C-s>e", function() ls.expand() end, { silent = true })

  vim.keymap.set({ "i", "s" }, "<C-s>]", function() ls.jump(1) end, { silent = true })
  vim.keymap.set({ "i", "s" }, "<C-s>[", function() ls.jump(-1) end, { silent = true })

  vim.keymap.set({ "i", "s" }, "<C-E>", function()
    if ls.choice_active() then
      ls.change_choice(1)
    end
  end, { silent = true })
end

return M



-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
