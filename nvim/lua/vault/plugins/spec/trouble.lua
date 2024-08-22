return {
    {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup({
                icons = false,
            })
            require("vault.keys").trouble()
        end
    },
}
