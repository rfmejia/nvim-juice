(local {: autoload} (require :nfnl.module))
(local string (autoload :nfnl.string))
(local util (autoload :juice.util))

(comment :TODO
  ["split to sbtn or scala-cli" :dadbod])

(fn read-env-pairs []
  "Returns a table of `vim.opt` key and `vim.env` value iff the env variable is not null"
  {:makeprg vim.env.NVIM_MAKEPRG
   :errorformat vim.env.NVIM_ERRORFORMAT
   :keywordprg vim.env.NVIM_KEYWORDPRG
   :formatprg vim.env.NVIM_FORMATPRG})

(lambda set-path-list [path-list]
  (let [paths (string.split path-list ":")]
    (set vim.opt.path ["." ""])
    (each [_ path (ipairs paths)]
      (: vim.opt.path :append path))))

(fn setup []
  (util.assoc-in vim.opt (read-env-pairs))
  (when vim.env.NVIM_PATH_LIST
    (set-path-list vim.env.NVIM_PATH_LIST)))

{: setup}
