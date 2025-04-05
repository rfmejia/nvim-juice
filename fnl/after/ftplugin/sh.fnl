(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))

(core.merge! vim.opt_local {:makeprg "sh %" :signcolumn :no :textwidth 80})
