(local {: autoload} (require :nfnl.module))
(local util (autoload :juice.util))

(set vim.opt.commentstring "-- %s")
(when (util.executable? :sqlformat)
  (set vim.opt.equalprg "sqlformat -r -k upper -"))
