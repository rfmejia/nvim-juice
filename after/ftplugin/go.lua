-- [nfnl] Compiled from fnl/after/ftplugin/go.fnl by https://github.com/Olical/nfnl, do not edit.
local lspconfig = autoload("lspconfig")
vim.opt_local.signcolumn = "yes:1"
local go_settings = {gopls = {analyses = {unusedparams = true}, staticcheck = true}}
return lspconfig.gopls.setup({["go-settings"] = go_settings})
