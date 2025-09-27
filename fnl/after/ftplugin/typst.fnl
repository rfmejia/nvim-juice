(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))

(core.merge! vim.opt_local {:shiftwidth 2
                            :tabstop 2
                            :textwidth 0
                            :wrap true
                            :spell true
                            :spelllang :en_us})
