-- [nfnl] fnl/plugin/builtin.fnl
vim.cmd.packadd("nvim.undotree")
vim.cmd.packadd("nvim.difftool")
return vim.keymap.set("n", "<leader>u", ":Undotree<cr>", {desc = "Toggle undotree view"})
