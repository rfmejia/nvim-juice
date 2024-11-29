(local {: autoload} (require :nfnl.module))
(local util (autoload :juice.util))

(set vim.opt.commentstring "-- %s")
(when (executable? :sqlformat)
 (set vim.opt.equalprg "sqlformat -r -k upper -"))
