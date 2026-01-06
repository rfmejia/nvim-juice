-- [nfnl] fnl/after/ftplugin/sql.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local util = autoload("juice.util")
vim.opt_local.commentstring = "-- %s"
if util["executable?"]("sqlformat") then
  --[[ "`sqlformat` is from `python-sqlparse` https://github.com/andialbrecht/sqlparse" ]]
  vim.opt_local.equalprg = "sqlformat -r -k lower -"
  return nil
else
  return nil
end
