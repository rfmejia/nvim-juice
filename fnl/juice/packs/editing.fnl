(local {: autoload} (require :nfnl.module))
(local pack (autoload :pack))
(local util (autoload :juice.util))

{:setup (fn []
          (pack.add [{:src "https://github.com/windwp/nvim-autopairs"}
                     {:src "https://github.com/kylechui/nvim-surround"}])
          (pack.load-on-keymap :nvim-surround [:cs :ds :ys]
                               #(util.call-setup :nvim-surround))
          (pack.load-on-event :nvim-autopairs :InsertEnter
                              {:desc "Lazily load nvim-autopairs"
                               :callback #(util.call :nvim-autopairs :setup
                                                     {:enable_check_bracket_line false})}))}
