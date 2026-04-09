(vim.pack.add ["https://github.com/windwp/nvim-autopairs"
               "https://github.com/kylechui/nvim-surround"
               "https://codeberg.org/andyg/leap.nvim"])

(let [{: autoload} (require :nfnl.module)
      util (autoload :juice.util)
      autopairs (autoload :nvim-autopairs)
      autopairs-opts {:enable_check_bracket_line false}
      leap-maps [[[:n :x :o] :s "<Plug>(leap)"]
                 [:n :S "<Plug>(leap-from-window)"]]]
  (autopairs.setup autopairs-opts)
  (util.set-keys leap-maps))
