(vim.pack.add ["https://github.com/rfmejia/nfnl"])

(local {: autoload} (require :nfnl.module))
(local util (autoload :juice.util))
(util.call-setup [:juice.options
                  :juice.filetypes
                  :juice.commands
                  :juice.autocmds
                  :juice.mappings
                  :juice.lsp
                  :juice.dotenvrc])

(vim.cmd.colorscheme :default-black)
;; (vim.cmd.colorscheme :ibm-blue)

;; TODO Create your own auto-pairs plugins
;; TODO Create your own surround plugins
;; TODO Finish marksman module

;; FIXME When highlighting TODO/FIXME/NOTE the highlight is enabled only when moving from a split
