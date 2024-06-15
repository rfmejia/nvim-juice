-- [nfnl] Compiled from fnl/juice/autocmds.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = autoload("juice.colors")
local show_extra_whitespace = _local_2_["show-extra-whitespace"]
local function setup()
  vim.api.nvim_create_user_command("TrimTrailingWhitespaces", ":%s/\\s\\+$", {})
  --[[ "Remember the cursor position of the last editing" ]]
  vim.api.nvim_create_autocmd("BufReadPost", {pattern = "*", command = "if line(\"'\\\"\") | exe \"'\\\"\" | endif"})
  vim.api.nvim_create_augroup("highlight-group", {})
  --[[ "highlight yanked text" ]]
  local function _3_()
    return vim.highlight.on_yank({timeout = 200, on_visual = false})
  end
  vim.api.nvim_create_autocmd("TextYankPost", {group = "highlight-group", pattern = "*", callback = _3_})
  --[[ "highlight TODO, FIXME and Note: keywords" ]]
  vim.api.nvim_create_autocmd({"WinEnter", "VimEnter"}, {group = "highlight-group", pattern = "*", command = ":silent! call matchadd('Todo','TODO\\|FIXME\\|Note:', -1)"})
  local function _4_()
    show_extra_whitespace()
    return vim.cmd("match ExtraWhitespace /\\s\\+$/")
  end
  vim.api.nvim_create_autocmd({"BufWinEnter", "InsertLeave"}, {group = "highlight-group", pattern = "*", callback = _4_})
  vim.api.nvim_create_autocmd({"BufWinLeave", "InsertEnter"}, {group = "highlight-group", pattern = "*", command = "hi clear ExtraWhitespace"})
  vim.api.nvim_create_augroup("terminal-group", {})
  --[[ "remove signcolumn in terminal mode" ]]
  return vim.api.nvim_create_autocmd("TermOpen", {group = "terminal-group", pattern = "*", command = "set signcolumn=no"})
end
return {setup = setup}
