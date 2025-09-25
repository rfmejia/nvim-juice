(local {: autoload} (require :nfnl.module))

(set vim.opt_local.signcolumn "yes:1")
(let [go-settings {:gopls {:analyses {:unusedparams true} :staticcheck true}}]
  (vim.lsp.enable :gopls {: go-settings}))
