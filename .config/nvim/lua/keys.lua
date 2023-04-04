vim.keymap.set('n', '<leader>e', vim.cmd.Ex, {silent = true, noremap = true})
function JbzCppMan()
    local old_isk = vim.o.iskeyword()
    vim.o.iskeyword = old_isk .. ":"
    local str = vim.fn.expand("<cword>")
    vim.o.iskeyword = old_isk
    vim.cmd("Man " .. str)
end

vim.cmd("command! JbzCppMan lua JbzCppMan()")


