(module scala {autoload {a aniseed.core s aniseed.string u util}})

(set vim.opt.shiftwidth 2)
(set vim.opt.tabstop 2)
(set vim.opt.expandtab true)
(set vim.opt.textwidth 100)

(defn format-fennel [path]
  (let [filename (if (s.blank? path)
                       (vim.fn.expand "%:p")
                     path)]
    (vim.fn.system [:fnlfmt :--fix filename])))

(vim.api.nvim_set_keymap :n :<localleader>cf ""
                         {:callback (fn []
                                      (->> (vim.fn.expand "%:p")
                                           (format-fennel)))})
