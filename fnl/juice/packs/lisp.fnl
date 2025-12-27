(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))
(local pack (autoload :pack))
(local util (autoload :juice.util))

{:setup (fn []
          (pack.add ["https://github.com/Olical/conjure"
                     "https://github.com/julienvincent/nvim-paredit"])
          (pack.load-on-event [:conjure :nvim-paredit] :FileType
                              {:pattern [:clojure :fennel]
                               :callback (fn []
                                           (util.call :nvim-paredit :setup
                                                      {:use_default_keys true
                                                       :indent {:enabled true}})
                                           (core.merge! vim.g
                                                        {"conjure#result#register" "*"
                                                         "conjure#mapping#doc_word" :gk
                                                         "conjure#log#botright" true}))}))}
