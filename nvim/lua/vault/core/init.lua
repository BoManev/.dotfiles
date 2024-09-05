require("vault.core.opt")
require("vault.core.ft")
require('vault.core.cmds')
require("vault.core.lazy")

local function set_filetype(pattern, filetype)
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = pattern,
        command = "set filetype=" .. filetype,
    })
end

set_filetype({ "docker-compose.yml" }, "yaml.docker-compose")
