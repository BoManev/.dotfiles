return {
    'nvim-neorg/neorg',
    build = ':Neorg sync-parsers',
    opts = {
        load = {
            ['core.defaults'] = {}, -- Loads default behaviour
            ['core.norg.concealer'] = {
                config = {
                    icon_preset = 'diamond'
                }
            }, -- Adds pretty icons to your documents
            ['core.norg.dirman'] = { -- Manages Neorg workspaces
                config = {
                    workspaces = {
                        vault = '~/bohq/vault',
                        wiki = '~/bohq/wiki'
                    },
                    default_workspace = "wiki"
                },
            },
        },
    },
    dependencies = { { "nvim-lua/plenary.nvim" } },
}
