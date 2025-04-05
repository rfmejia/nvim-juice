(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))

(core.merge! vim.opt_local {:makeprg "/usr/bin/env bash %"
                            :signcolumn :no
                            :textwidth 80})
