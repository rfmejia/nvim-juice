(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))

(core.merge! vim.opt_local {:shiftwidth 4 :tabstop 4 :textwidth 100})
