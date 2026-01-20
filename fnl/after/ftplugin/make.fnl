(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))

(core.merge! vim.opt_local {;; Use tabs instead of spaces
                            :expandtab false
                            :shiftwidth 4
                            :tabstop 4})
