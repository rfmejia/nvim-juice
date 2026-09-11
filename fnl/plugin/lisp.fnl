(vim.pack.add ["https://github.com/Olical/conjure"
               "https://github.com/julienvincent/nvim-paredit"])

(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))
(local paredit (autoload :nvim-paredit))

(let [paredit-opts {:use_default_keys true :indent {:enabled true}}
      conjure-opts {"conjure#result#register" "*"
                    "conjure#mapping#doc_word" :gk
                    "conjure#log#botright" true}]
  (paredit.setup paredit-opts)
  (core.merge! vim.g conjure-opts))
