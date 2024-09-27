(local {: autoload} (require :nfnl.module))
(local util (autoload :juice.util))

(util.assoc-in vim.opt {:shiftwidth 2
                        :tabstop 2
                        :textwidth 80
                        :wrap true
                        :spell true
                        :spelllang :en_us})
