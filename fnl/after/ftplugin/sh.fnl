(local {: autoload} (require :nfnl.module))
(local util (autoload :juice.util))

(util.assoc-in vim.opt_local {:makeprg "sh %" :signcolumn :no :textwidth 80})
