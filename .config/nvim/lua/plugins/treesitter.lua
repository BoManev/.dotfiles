local M = {
    "nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
}

function M.config()
    require'nvim-treesitter.configs'.setup {
        ensure_installed = {'c', 'lua', 'cpp', 'python', 'javascript', 'typescript', 'vim', 'help', 'query' },
        sync_install = false,
        auto_install = true,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        }
    }
end

return M
