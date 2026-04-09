(vim.pack.add ["https://github.com/windwp/nvim-autopairs"
               "https://github.com/kylechui/nvim-surround"])

(let [{: autoload} (require :nfnl.module)
      autopairs (autoload :nvim-autopairs)
      opts {:enable_check_bracket_line false}]
  (autopairs.setup opts))
