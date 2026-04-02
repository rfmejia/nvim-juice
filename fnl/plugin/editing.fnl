(vim.pack.add ["https://github.com/windwp/nvim-autopairs"
               "https://github.com/kylechui/nvim-surround"])

(let [{: autoload} (require :nfnl.module)
      util (autoload :juice.util)
      autopairs-opts {:enable_check_bracket_line false}]
  (util.call :nvim-autopairs :setup autopairs-opts))
