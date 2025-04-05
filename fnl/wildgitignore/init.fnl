(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))
(local string (autoload :nfnl.string))

(fn starts-with? [str prefix]
  (= prefix (str:sub 1 (length prefix))))

(lambda is-dir? [path]
  "Checks if path is a dir (will miss empty or non-existent dirs)"
  (not= nil ((vim.fs.dir path))))

(fn update-wildignore []
  (case (core.slurp :.gitignore)
    gitignore (let [lines (core.map string.trim (string.split gitignore "\n"))
                    entries (core.filter #(not (or (string.blank? $1)
                                                   (starts-with? $1 "#")
                                                   (starts-with? $1 "!")))
                                         lines)
                    suffixed (core.map #(if (string.ends-with? $1 "/")
                                            (.. $1 "*")
                                            (is-dir? $1)
                                            (.. $1 "/*")
                                            :else
                                            $1)
                                       entries)
                    prefixed (core.map #(if (starts-with? $1 "/")
                                            (.. "**" $1)
                                            (.. "**/" $1))
                                       suffixed)]
                (set vim.opt.wildignore "")
                (core.map #(vim.opt.wildignore:append $1) prefixed))))

(fn setup []
  (vim.api.nvim_create_augroup :wildignore-group {:clear true})
  (vim.api.nvim_create_autocmd :VimEnter
                               {:group :wildignore-group
                                :pattern "*"
                                :callback update-wildignore})
  (vim.api.nvim_create_autocmd :DirChanged
                               {:group :wildignore-group
                                :pattern :global
                                :callback update-wildignore})
  (vim.api.nvim_create_autocmd :FileWritePost
                               {:group :wildignore-group
                                :pattern :.gitignore
                                :callback update-wildignore}))

{: setup}
