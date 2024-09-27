(local {: autoload} (require :nfnl.module))
(local util (autoload :juice.util))

(util.assoc-in vim.opt {:makeprg "sh %" :signcolumn :no :textwidth 80})
