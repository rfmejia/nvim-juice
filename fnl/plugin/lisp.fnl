(let [{: autoload} (require :nfnl.module)
      packs ["https://github.com/Olical/conjure"
             "https://github.com/julienvincent/nvim-paredit"]
      paredit-opts {:use_default_keys true :indent {:enabled true}}
      conjure-opts {"conjure#result#register" "*"
                    "conjure#mapping#doc_word" :gk
                    "conjure#log#botright" true}]
  (vim.pack.add packs)
  (let [core (autoload :nfnl.core)
        util (autoload :juice.util)]
    (util.call :nvim-paredit :setup paredit-opts)
    (core.merge! vim.g conjure-opts)))
