-- [nfnl] Compiled from fnl/juice/autocmds.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = autoload("juice.colors")
local show_extra_whitespace = _local_2_["show-extra-whitespace"]
local _local_3_ = autoload("juice.statusline")
local git_branch = _local_3_["git-branch"]
local git_file_status = _local_3_["git-file-status"]
local _local_4_ = autoload("juice.util")
local augroup = _local_4_["augroup"]
local autocmd = _local_4_["autocmd"]
local user_command = _local_4_["user-command"]
local function setup()
  user_command("TrimTrailingWhitespaces", ":%s/\\s\\+$", {})
  --[[ "Remember the cursor position of the last editing" ]]
  autocmd("BufReadPost", {pattern = "*", command = "if line(\"'\\\"\") | exe \"'\\\"\" | endif"})
  local function _5_()
    git_file_status()
    return git_branch()
  end
  autocmd({"BufEnter", "BufWritePost"}, {pattern = "*", callback = _5_})
  augroup("highlight-group", {})
  --[[ "highlight yanked text" ]]
  local function _6_()
    return vim.highlight.on_yank({timeout = 200, on_visual = false})
  end
  autocmd("TextYankPost", {group = "highlight-group", pattern = "*", callback = _6_})
  --[[ "highlight TODO, FIXME and Note: keywords" ]]
  autocmd({"WinEnter", "VimEnter"}, {group = "highlight-group", pattern = "*", command = ":silent! call matchadd('Todo','TODO\\|FIXME\\|Note:', -1)"})
  local function _7_()
    show_extra_whitespace()
    return vim.cmd("match ExtraWhitespace /\\s\\+$/")
  end
  autocmd({"BufWinEnter", "InsertLeave"}, {group = "highlight-group", pattern = "*", callback = _7_})
  autocmd({"BufWinLeave", "InsertEnter"}, {group = "highlight-group", pattern = "*", command = "hi clear ExtraWhitespace"})
  augroup("terminal-group", {})
  --[[ "remove signcolumn in terminal mode" ]]
  return autocmd("TermOpen", {group = "terminal-group", pattern = "*", command = "set signcolumn=no"})
end
return {setup = setup}
