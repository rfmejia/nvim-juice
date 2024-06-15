-- [nfnl] Compiled from fnl/juice/whitespace.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local colors = autoload("juice.colors")
local function setup()
  vim.api.nvim_create_user_command("TrimTrailingWhitespaces", ":%s/\\s\\+$", {})
  local function _2_()
    colors["show-extra-whitespace"]()
    return vim.cmd("match ExtraWhitespace /\\s\\+$/")
  end
  vim.api.nvim_create_autocmd({"BufWinEnter", "InsertLeave"}, {group = "highlight-group", pattern = "*", callback = _2_})
  return vim.api.nvim_create_autocmd({"BufWinLeave", "InsertEnter"}, {group = "highlight-group", pattern = "*", command = "hi clear ExtraWhitespace"})
end
return {setup = setup}
