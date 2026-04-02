(vim.pack.add ["https://github.com/Olical/conjure"
               "https://github.com/julienvincent/nvim-paredit"])

(let [{: autoload} (require :nfnl.module)
      core (autoload :nfnl.core)
      util (autoload :juice.util)
      paredit-opts {:use_default_keys true :indent {:enabled true}}
      conjure-opts {"conjure#result#register" "*"
                    "conjure#mapping#doc_word" :gk
                    "conjure#log#botright" true}]
  (util.call :nvim-paredit :setup paredit-opts)
  (core.merge! vim.g conjure-opts))
