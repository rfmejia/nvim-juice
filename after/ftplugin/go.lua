-- [nfnl] fnl/after/ftplugin/go.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
vim.opt_local.signcolumn = "yes:1"
local go_settings = {gopls = {analyses = {unusedparams = true}, staticcheck = true}}
return vim.lsp.enable("gopls", {["go-settings"] = go_settings})
