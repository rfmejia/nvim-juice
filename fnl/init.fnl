(vim.pack.add ["https://github.com/rfmejia/nfnl"])

(comment "nfnl.module.autoload loads a module at the first callsite, not upon
         require - this should decrease startup time")

(local {: autoload} (require :nfnl.module))
(local util (autoload :juice.util))
(util.call-setup [:juice.options
                  :juice.colors
                  :juice.filetypes
                  :juice.commands
                  :juice.autocmds
                  :juice.mappings
                  :juice.lsp
                  :juice.dotenvrc])
