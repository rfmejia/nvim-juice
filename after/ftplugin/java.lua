-- [nfnl] fnl/after/ftplugin/java.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
vim.opt_local.signcolumn = "yes:1"
return vim.lsp.enable("jdtls")
