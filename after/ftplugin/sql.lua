-- [nfnl] fnl/after/ftplugin/sql.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local core = autoload("nfnl.core")
local str = autoload("nfnl.string")
local util = autoload("juice.util")
vim.g.omni_sql_default_compl_type = "syntax"
if util["executable?"]("sqlformat") then
  --[[ "`sqlformat` is from `python-sqlparse` https://github.com/andialbrecht/sqlparse" ]]
  local cmd = "sqlformat --reindent --keywords upper --wrap_after 80 -"
  vim.opt_local.equalprg = cmd
else
end
if vim.fn.filereadable(".my.cnf") then
  local stdio_cmd = "mariadb --defaults-file=.my.cnf --table --unbuffered"
  return core["merge!"](vim.g, {["conjure#client#sql#stdio#command"] = stdio_cmd})
else
  return nil
end
