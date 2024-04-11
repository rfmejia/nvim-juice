-- [nfnl] Compiled from fnl/after/ftplugin/scala.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = autoload("nfnl.string")
local blank_3f = _local_2_["blank?"]
local _local_3_ = autoload("juice.util")
local nmap = _local_3_["nmap"]
local set_opts = _local_3_["set-opts"]
local user_command = _local_3_["user-command"]
set_opts({shiftwidth = 2, tabstop = 2, expandtab = true, textwidth = 100, signcolumn = "yes:1"})
--[[ "FIXME This doesn't seem to be reflected" "indentkeys:remove" ["<>>"] ]]
local function run_scalafmt(path)
  local filename
  if blank_3f(path) then
    filename = vim.fn.expand("%:p")
  else
    filename = path
  end
  return vim.fn.system({"scalafmt", "--mode", "changed", "--config", ".scalafmt.conf", filename, filename})
end
local function _5_()
  return run_scalafmt()
end
user_command("ScalafmtApply", _5_, {bang = true})
local function _6_()
  return run_scalafmt(vim.fn.expand("%:p"))
end
nmap("<localleader>cf", _6_, {"noremap", "nowait", "silent"})
return nmap("<localleader>s", "vip:sort<cr>", {"noremap", "nowait", "silent"})
