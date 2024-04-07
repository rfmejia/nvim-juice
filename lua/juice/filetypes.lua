-- [nfnl] Compiled from fnl/juice/filetypes.fnl by https://github.com/Olical/nfnl, do not edit.
vim.cmd("filetype plugin on")
vim.api.nvim_create_augroup("ftplugins-group", {})
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {group = "ftplugins-group", pattern = {"*.txt", "*.text"}, command = "setf text"})
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {group = "ftplugins-group", pattern = {"*bash_profile", "*.bash"}, command = "setf bash"})
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {group = "ftplugins-group", pattern = "tmux.conf", command = "setf tmux"})
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {group = "ftplugins-group", pattern = {"*.sbt", "*.sc"}, command = "set ft=scala"})
return vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {group = "ftplugins-group", pattern = "Jenkinsfile", command = "set ft=groovy"})
