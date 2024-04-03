-- [nfnl] Compiled from fnl/juice/commands.fnl by https://github.com/Olical/nfnl, do not edit.
vim.api.nvim_create_user_command("TrimTrailingWhitespaces", ":%s/\\s\\+$", {})
vim.api.nvim_create_autocmd("BufReadPost", {pattern = "*", command = "if line(\"'\\\"\") | exe \"'\\\"\" | endif"})
local function _1_()
  local sl = require("juice.statusline")
  sl["git-file-status"]()
  return sl["git-branch"]()
end
vim.api.nvim_create_autocmd({"BufEnter", "BufWritePost"}, {pattern = "*", callback = _1_})
vim.api.nvim_create_augroup("highlight-group", {})
local function _2_()
  return vim.highlight.on_yank({timeout = 200, on_visual = false})
end
vim.api.nvim_create_autocmd("TextYankPost", {group = "highlight-group", pattern = "*", callback = _2_})
vim.api.nvim_create_autocmd({"WinEnter", "VimEnter"}, {group = "highlight-group", pattern = "*", command = ":silent! call matchadd('Todo','TODO\\|FIXME\\|Note:', -1)"})
local function _3_()
  local c = require("juice.colors")
  c["show-extra-whitespace"]()
  return vim.cmd("match ExtraWhitespace /\\s\\+$/")
end
vim.api.nvim_create_autocmd({"BufWinEnter", "InsertLeave"}, {group = "highlight-group", pattern = "*", callback = _3_})
vim.api.nvim_create_autocmd({"BufWinLeave", "InsertEnter"}, {group = "highlight-group", pattern = "*", command = "hi clear ExtraWhitespace"})
vim.api.nvim_create_augroup("terminal-group", {})
return vim.api.nvim_create_autocmd("TermOpen", {group = "terminal-group", pattern = "*", command = "set signcolumn=no"})
