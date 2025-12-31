(let [{: autoload} (require :nfnl.module)
      pacman (autoload :pacman)
      util (autoload :juice.util)
      packs ["https://github.com/windwp/nvim-autopairs"
             "https://github.com/kylechui/nvim-surround"]
      autopairs-opts {:enable_check_bracket_line false}]
  (pacman.add packs)
  (pacman.load-on-keymap :nvim-surround [:cs :ds :ys]
                         #(util.call-setup :nvim-surround))
  (pacman.load-on-event :nvim-autopairs :InsertEnter
                        {:desc "Lazily load nvim-autopairs"
                         :callback #(util.call :nvim-autopairs :setup
                                               autopairs-opts)}))
