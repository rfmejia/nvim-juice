(local {: autoload} (require :nfnl.module))
(local util (autoload :juice.util))

(set vim.opt_local.commentstring "-- %s")
(when (util.executable? :sqlformat)
  (set vim.opt_local.equalprg "sqlformat -r -k upper -"))
