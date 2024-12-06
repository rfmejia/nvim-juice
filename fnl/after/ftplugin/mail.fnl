(local {: autoload} (require :nfnl.module))
(local util (autoload :juice.util))

(util.assoc-in vim.opt_local {:shiftwidth 2
                              :tabstop 2
                              :textwidth 80
                              :wrap true
                              :signcolumn "yes:1"
                              :spell true
                              :spelllang :en_us})
