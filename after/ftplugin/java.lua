-- [nfnl] fnl/after/ftplugin/java.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local lspconfig = autoload("lspconfig")
vim.opt_local.signcolumn = "yes:1"
return lspconfig.jdtls.setup({})
