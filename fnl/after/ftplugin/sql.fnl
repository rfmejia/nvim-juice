(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))
(local str (autoload :nfnl.string))
(local util (autoload :juice.util))

(set vim.g.omni_sql_default_compl_type :syntax)

(when (util.executable? :sqlformat)
  (comment "`sqlformat` is from `python-sqlparse` https://github.com/andialbrecht/sqlparse")
  (let [cmd "sqlformat --reindent --keywords upper --wrap_after 80 -"]
    (set vim.opt_local.equalprg cmd)))

(if (vim.fn.filereadable :.my.cnf)
    (let [stdio-cmd "mariadb --defaults-file=.my.cnf --table --unbuffered"]
      (core.merge! vim.g {"conjure#client#sql#stdio#command" stdio-cmd})))
