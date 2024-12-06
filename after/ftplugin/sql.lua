-- [nfnl] Compiled from fnl/after/ftplugin/sql.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local util = autoload("juice.util")
vim.opt_local.commentstring = "-- %s"
if util["executable?"]("sqlformat") then
  vim.opt_local.equalprg = "sqlformat -r -k upper -"
  return nil
else
  return nil
end
