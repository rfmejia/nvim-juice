-- [nfnl] Compiled from fnl/after/ftplugin/scala.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = autoload("nfnl.string")
local blank_3f = _local_2_["blank?"]
local _local_3_ = autoload("juice.util")
local executable_3f = _local_3_["executable?"]
local bufmap = _local_3_["bufmap"]
local set_opts = _local_3_["set-opts"]
set_opts({shiftwidth = 2, tabstop = 2, expandtab = true, textwidth = 100, signcolumn = "yes:1"})
--[[ "FIXME This doesn't seem to be reflected" "indentkeys:remove" ["<>>"] ]]
local function run_scalafmt(path)
  local filename
  if blank_3f(path) then
    filename = vim.fn.expand("%:p")
  else
    filename = path
  end
  local scalafmt_cmd = {"scalafmt", "--mode", "changed", "--config", ".scalafmt.conf", filename, filename}
  local _5_, _6_ = vim.fn.system(scalafmt_cmd)
  if (nil ~= _5_) then
    local ok = _5_
    return vim.cmd("e!")
  elseif ((_5_ == nil) and (nil ~= _6_)) then
    local err_msg = _6_
    return print("Could not run `scalafmt`: ", err_msg)
  else
    return nil
  end
end
local function _8_()
  return run_scalafmt()
end
vim.api.nvim_buf_create_user_command(vim.api.nvim_get_current_buf(), "ScalafmtApply", _8_, {bang = true})
--[[ "Make sure we respect lsp if it's enabled" (bufmap (vim.api.nvim_get_current_buf) {:n {:<localleader>cf [(fn [] (run-scalafmt (vim.fn.expand "%:p"))) ["noremap" "nowait" "silent"] ""]}}) ]]
bufmap(vim.api.nvim_get_current_buf(), {n = {["<localleader>s"] = {"vip:sort<cr>", {"noremap", "nowait", "silent"}, "sort in paragraph"}}})
if executable_3f("sbtn") then
  bufmap(vim.api.nvim_get_current_buf(), {n = {["<leader>os"] = {":!tmux split-window -v -l 30\\% sbtn<cr><cr>", {"noremap", "silent"}, "open sbtn in a tmux split"}}})
else
end
if executable_3f("scala-cli") then
  return bufmap(vim.api.nvim_get_current_buf(), {n = {["<leader>oc"] = {":!tmux split-window -v -l 30\\% scala-cli console %<cr><cr>", {"noremap", "silent"}, "open scala-cli in a tmux split"}}})
else
  return nil
end
