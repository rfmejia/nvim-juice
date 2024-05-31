-- [nfnl] Compiled from fnl/juice/autocmds.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = autoload("juice.colors")
local show_extra_whitespace = _local_2_["show-extra-whitespace"]
local _local_3_ = autoload("juice.statusline")
local git_branch = _local_3_["git-branch"]
local git_file_status = _local_3_["git-file-status"]
local function setup()
  vim.api.nvim_create_user_command("TrimTrailingWhitespaces", ":%s/\\s\\+$", {})
  --[[ "Remember the cursor position of the last editing" ]]
  vim.api.nvim_create_autocmd("BufReadPost", {pattern = "*", command = "if line(\"'\\\"\") | exe \"'\\\"\" | endif"})
  local function _4_()
    git_file_status()
    return git_branch()
  end
  vim.api.nvim_create_autocmd({"BufEnter", "BufWritePost"}, {pattern = "*", callback = _4_})
  vim.api.nvim_create_augroup("highlight-group", {})
  --[[ "highlight yanked text" ]]
  local function _5_()
    return vim.highlight.on_yank({timeout = 200, on_visual = false})
  end
  vim.api.nvim_create_autocmd("TextYankPost", {group = "highlight-group", pattern = "*", callback = _5_})
  --[[ "highlight TODO, FIXME and Note: keywords" ]]
  vim.api.nvim_create_autocmd({"WinEnter", "VimEnter"}, {group = "highlight-group", pattern = "*", command = ":silent! call matchadd('Todo','TODO\\|FIXME\\|Note:', -1)"})
  local function _6_()
    show_extra_whitespace()
    return vim.cmd("match ExtraWhitespace /\\s\\+$/")
  end
  vim.api.nvim_create_autocmd({"BufWinEnter", "InsertLeave"}, {group = "highlight-group", pattern = "*", callback = _6_})
  vim.api.nvim_create_autocmd({"BufWinLeave", "InsertEnter"}, {group = "highlight-group", pattern = "*", command = "hi clear ExtraWhitespace"})
  vim.api.nvim_create_augroup("terminal-group", {})
  --[[ "remove signcolumn in terminal mode" ]]
  return vim.api.nvim_create_autocmd("TermOpen", {group = "terminal-group", pattern = "*", command = "set signcolumn=no"})
end
return {setup = setup}
