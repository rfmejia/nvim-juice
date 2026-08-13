(vim.pack.add ["https://github.com/rfmejia/nfnl"])

(let [{: autoload} (require :nfnl.module)
      util (autoload :juice.util)]
  (util.call-setup [:juice.options
                    :juice.colors
                    :juice.filetypes
                    :juice.commands
                    :juice.autocmds
                    :juice.mappings
                    :juice.lsp
                    :juice.dotenvrc]))
