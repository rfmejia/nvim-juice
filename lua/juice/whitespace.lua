-- [nfnl] Compiled from fnl/juice/whitespace.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local colors = autoload("juice.colors")
local function setup()
  local hi_cmd = "hi ExtraWhitespace gui=undercurl guifg=red"
  local match_all_cmd = "match ExtraWhitespace /\\s\\+$/"
  local match_partial_cmd = "match ExtraWhitespace /\\s\\+\\%#\\@<!$/"
  local clear_matches_cmd = "call clearmatches()"
  vim.cmd(hi_cmd)
  vim.cmd(match_all_cmd)
  vim.api.nvim_create_augroup("whitespace-group", {})
  vim.api.nvim_create_autocmd("ColorScheme", {group = "whitespace-group", pattern = "*", command = hi_cmd})
  vim.api.nvim_create_autocmd({"BufWinEnter", "InsertLeave"}, {group = "whitespace-group", pattern = "*", command = match_all_cmd})
  vim.api.nvim_create_autocmd("InsertEnter", {group = "whitespace-group", pattern = "*", command = match_partial_cmd})
  vim.api.nvim_create_autocmd("BufWinLeave", {group = "whitespace-group", pattern = "*", command = clear_matches_cmd})
  return vim.api.nvim_create_user_command("TrimTrailingWhitespaces", ":%s/\\s\\+$", {})
end
return {setup = setup}
