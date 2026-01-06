(local {: autoload} (require :nfnl.module))
(local util (autoload :juice.util))

(set vim.opt_local.commentstring "-- %s")
(when (util.executable? :sqlformat)
  (comment "`sqlformat` is from `python-sqlparse` https://github.com/andialbrecht/sqlparse")
  (set vim.opt_local.equalprg "sqlformat -r -k lower -"))
