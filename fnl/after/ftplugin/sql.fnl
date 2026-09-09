(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))
(local util (autoload :juice.util))

(set vim.opt_local.commentstring "-- %s")
(set vim.g.omni_sql_default_compl_type :syntax)
(when (util.executable? :sqlformat)
  (comment "`sqlformat` is from `python-sqlparse` https://github.com/andialbrecht/sqlparse")
  (set vim.opt_local.equalprg "sqlformat -r -k lower -"))

(if (vim.fn.filereadable ".my.cnf")
 (core.merge! vim.g {"conjure#client#sql#stdio#command" "mariadb --defaults-file=.my.cnf"}))
