(let [{: autoload} (require :nfnl.module)
      util (autoload :juice.util)
      packs ["https://github.com/windwp/nvim-autopairs"
             "https://github.com/kylechui/nvim-surround"]
      autopairs-opts {:enable_check_bracket_line false}]
  (vim.pack.add packs)
  (util.call :nvim-autopairs :setup autopairs-opts))
