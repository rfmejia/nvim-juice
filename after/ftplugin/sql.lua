-- [nfnl] fnl/after/ftplugin/sql.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local core = autoload("nfnl.core")
local str = autoload("nfnl.string")
local util = autoload("juice.util")
vim.opt_local.commentstring = "-- %s"
vim.g.omni_sql_default_compl_type = "syntax"
if util["executable?"]("sqlformat") then
  --[[ "`sqlformat` is from `python-sqlparse` https://github.com/andialbrecht/sqlparse" ]]
  local opts = {"sqlformat", "--reindent", "--keywords", "upper", "--wrap_after", 80, "-"}
  vim.opt_local.equalprg = str.join(" ", opts)
else
end
if vim.fn.filereadable(".my.cnf") then
  return core["merge!"](vim.g, {["conjure#client#sql#stdio#command"] = "mariadb --defaults-file=.my.cnf"})
else
  return nil
end
