(let [{: autoload} (require :nfnl.module)
      pacman (autoload :pacman)
      packs ["https://github.com/Olical/conjure"
             "https://github.com/julienvincent/nvim-paredit"]
      paredit-opts {:use_default_keys true :indent {:enabled true}}
      conjure-opts {"conjure#result#register" "*"
                    "conjure#mapping#doc_word" :gk
                    "conjure#log#botright" true}]
  (pacman.add packs)
  (pacman.load-on-event [:conjure :nvim-paredit] :FileType
                        {:pattern [:clojure :fennel]
                         :callback #(let [core (autoload :nfnl.core)
                                          util (autoload :juice.util)]
                                      (util.call :nvim-paredit :setup
                                                 paredit-opts)
                                      (core.merge! vim.g conjure-opts))}))
