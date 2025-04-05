-- [nfnl] Compiled from fnl/after/ftplugin/java.fnl by https://github.com/Olical/nfnl, do not edit.
local lspconfig = autoload("lspconfig")
vim.opt_local.signcolumn = "yes:1"
return lspconfig.jdtls.setup({})
