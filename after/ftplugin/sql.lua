-- [nfnl] Compiled from fnl/after/ftplugin/sql.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local util = autoload("juice.util")
vim.opt.commentstring = "-- %s"
if __fnl_global__executable_3f("sqlformat") then
  vim.opt.equalprg = "sqlformat -r -k upper -"
  return nil
else
  return nil
end
