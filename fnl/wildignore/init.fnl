(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))
(local string (autoload :nfnl.string))
(local util (autoload :juice.util))

(fn starts-with? [str prefix]
  (= prefix (: str :sub 1 (length prefix))))

(fn update-wildignore []
  (local gitignore (core.slurp :.gitignore))
  (when gitignore
    (set vim.opt.wildignore "")
    (let [items (core.map string.trim (string.split gitignore "\n"))
          filtered (core.filter #(not (or (string.blank? $1)
                                          (starts-with? $1 "#")
                                          (starts-with? $1 "!")))
                                items)
          prefixed (core.map #(if (starts-with? $1 "/")
                                  (.. "**" $1)
                                  (.. "**/" $1))
                             filtered)
          suffixed (core.map #(if (string.ends-with? $1 "/") (.. $1 "*") $1)
                             prefixed)]
      ;; (core.map vim.print suffixed)
      (core.map #(: vim.opt.wildignore :append $1) suffixed))))

(fn setup []
  (vim.api.nvim_create_augroup :wildignore-group {:clear true})
  (vim.api.nvim_create_autocmd :DirChanged
                               {:group :wildignore-group
                                :pattern :global
                                :callback update-wildignore})
  (vim.api.nvim_create_autocmd :FileWritePost
                               {:group :wildignore-group
                                :pattern :.gitignore
                                :callback update-wildignore})
  (update-wildignore))

{: setup}
