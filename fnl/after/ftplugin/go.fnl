(local {: autoload} (require :nfnl.module))
(local lspconfig (autoload :lspconfig))

(set vim.opt_local.signcolumn "yes:1")
(let [go-settings {:gopls {:analyses {:unusedparams true} :staticcheck true}}]
  (lspconfig.gopls.setup {: go-settings}))
