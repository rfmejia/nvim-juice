(local {: autoload} (require :nfnl.module))
(local util (autoload :juice.util))

(util.assoc-in vim.opt {:makeprg "/usr/bin/env bash %" :signcolumn :no :textwidth 80})
