-- [nfnl] fnl/after/ftplugin/lua.fnl
vim.opt_local.signcolumn = "yes:1"
return vim.lsp.enable("lua_ls")
