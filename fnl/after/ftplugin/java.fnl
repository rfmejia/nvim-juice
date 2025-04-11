(local {: autoload} (require :nfnl.module))
(local lspconfig (autoload :lspconfig))

(set vim.opt_local.signcolumn "yes:1")
(lspconfig.jdtls.setup {})
