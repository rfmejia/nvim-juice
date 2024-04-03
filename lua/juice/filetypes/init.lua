-- [nfnl] Compiled from fnl/juice/filetypes/init.fnl by https://github.com/Olical/nfnl, do not edit.
vim.cmd("filetype plugin on")
vim.api.nvim_create_augroup("ftplugins-group", {})
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {group = "ftplugins-group", pattern = {"*.txt", "*.text"}, command = "setf text"})
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {group = "ftplugins-group", pattern = {"*bash_profile", "*.bash"}, command = "setf bash"})
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {group = "ftplugins-group", pattern = "tmux.conf", command = "setf tmux"})
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {group = "ftplugins-group", pattern = {"*.sbt", "*.sc"}, command = "set ft=scala"})
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {group = "ftplugins-group", pattern = "Jenkinsfile", command = "set ft=groovy"})
local function _1_()
  return require("juice.filetypes.bash")
end
vim.api.nvim_create_autocmd("FileType", {group = "ftplugins-group", pattern = {"sh", "bash"}, callback = _1_})
local function _2_()
  return require("juice.filetypes.fennel")
end
vim.api.nvim_create_autocmd("FileType", {group = "ftplugins-group", pattern = "fennel", callback = _2_})
local function _3_()
  return require("juice.filetypes.go")
end
vim.api.nvim_create_autocmd("FileType", {group = "ftplugins-group", pattern = "go", callback = _3_})
local function _4_()
  return require("juice.filetypes.mail")
end
vim.api.nvim_create_autocmd("FileType", {group = "ftplugins-group", pattern = "mail", callback = _4_})
local function _5_()
  return require("juice.filetypes.asciidoc")
end
vim.api.nvim_create_autocmd("FileType", {group = "ftplugins-group", pattern = "asciidoc", callback = _5_})
local function _6_()
  return require("juice.filetypes.markdown")
end
vim.api.nvim_create_autocmd("FileType", {group = "ftplugins-group", pattern = "markdown", callback = _6_})
local function _7_()
  return require("juice.filetypes.scala")
end
vim.api.nvim_create_autocmd("FileType", {group = "ftplugins-group", pattern = "scala", callback = _7_})
local function _8_()
  local u = require("util")
  vim.g.netrw_altfile = 1
  vim.g.netrw_sort_by = "exten"
  vim.g.netrw_sort_options = "i"
  return u.nmap("?", ":h netrw-quickmap<CR>", {"noremap"})
end
return vim.api.nvim_create_autocmd("FileType", {group = "ftplugins-group", pattern = "netrw", callback = _8_})
