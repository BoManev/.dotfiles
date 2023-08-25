vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.wo.colorcolumn = "120"

-- Add `gf` support for Lua files:
vim.opt_local.include = [[\v<((do|load)file|require)[^''"]*[''"]\zs[^''"]+]]
vim.opt_local.includeexpr = "substitute(v:fname,'\\.','/','g')"

for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
    vim.opt_local.path:append(path .. "/lua")
end

vim.opt_local.suffixes:prepend(".lua")
