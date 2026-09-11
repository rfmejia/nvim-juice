(vim.pack.add ["https://github.com/windwp/nvim-autopairs"
               "https://github.com/kylechui/nvim-surround"
               "https://codeberg.org/andyg/leap.nvim"])

(local {: autoload} (require :nfnl.module))
(local util (autoload :juice.util))
(local autopairs (autoload :nvim-autopairs))

(let [autopairs-opts {:enable_check_bracket_line false}
      leap-maps [[[:n :x :o] :s "<Plug>(leap)"]
                 [:n :S "<Plug>(leap-from-window)"]]]
  (autopairs.setup autopairs-opts)
  (util.set-keys leap-maps))
