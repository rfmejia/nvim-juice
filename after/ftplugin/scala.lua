-- [nfnl] Compiled from fnl/after/ftplugin/scala.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local str = autoload("nfnl.string")
local util = autoload("juice.util")
util["set-opts"]({shiftwidth = 2, tabstop = 2, expandtab = true, textwidth = 100, signcolumn = "yes:1"})
--[[ "FIXME This doesn't seem to be reflected" "indentkeys:remove" ["<>>"] ]]
local function run_scalafmt(path)
  local filename
  if str["blank?"](path) then
    filename = vim.fn.expand("%:p")
  else
    filename = path
  end
  local scalafmt_cmd = {"scalafmt", "--mode", "changed", "--config", ".scalafmt.conf", filename, filename}
  local _3_, _4_ = vim.fn.system(scalafmt_cmd)
  if (nil ~= _3_) then
    local ok = _3_
    return vim.cmd("e!")
  elseif ((_3_ == nil) and (nil ~= _4_)) then
    local err_msg = _4_
    return print("Could not run `scalafmt`: ", err_msg)
  else
    return nil
  end
end
local function _6_()
  return run_scalafmt()
end
vim.api.nvim_buf_create_user_command(vim.api.nvim_get_current_buf(), "ScalafmtApply", _6_, {bang = true})
--[[ "Make sure we respect lsp if it's enabled" (util.bufmap (vim.api.nvim_get_current_buf) {:n {:<localleader>cf [(hashfn (run-scalafmt (vim.fn.expand "%:p"))) ["noremap" "nowait" "silent"] ""]}}) ]]
util.bufmap(vim.api.nvim_get_current_buf(), {n = {["<localleader>s"] = {"vip:sort<cr>", {"noremap", "nowait", "silent"}, "sort in paragraph"}}})
if util["executable?"]("sbtn") then
  bufmap(vim.api.nvim_get_current_buf(), {n = {["<leader>os"] = {":!tmux split-window -v -l 30\\% sbtn<cr><cr>", {"noremap", "silent"}, "open sbtn in a tmux split"}}})
else
end
if util["executable?"]("scala-cli") then
  return bufmap(vim.api.nvim_get_current_buf(), {n = {["<leader>oc"] = {":!tmux split-window -v -l 30\\% scala-cli console %<cr><cr>", {"noremap", "silent"}, "open scala-cli in a tmux split"}}})
else
  return nil
end
