local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- providers and builtins
local builtins = {
    'tar',
    'zip',
    'gzip',
    'tarPlugin',
    'zipPlugin',
    'getscript',
    'getscriptPlugin',
    'vimball',
    'vimballPlugin',
    '2html_plugin',
    'logipat',
    'rrhelper',
    'tutor',
    'tohtml',
}
-- for _, builtin in ipairs(builtins) do
--     vim.g['loaded_' .. builtin] = 1
-- end

local providers = { 'perl', 'node', 'ruby', 'python3', 'python' }
for _, provider in ipairs(providers) do
    vim.g['loaded_' .. provider .. '_provider'] = 0
end
require("lazy").setup({
    spec = "vault.plugins",
    performance = {
        rtp = {
            disabled_plugins = builtins
        }
    }
})
