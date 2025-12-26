(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))
(local string (autoload :nfnl.string))

(comment :TODO "Load the following special envs"
  ["split to sbtn or scala-cli" :dadbod])

(fn read-env-pairs []
  "Returns a table of `vim.opt` key and `vim.env` value iff the env variable is not null"
  {:makeprg vim.env.NVIM_MAKEPRG
   :errorformat vim.env.NVIM_ERRORFORMAT
   :keywordprg vim.env.NVIM_KEYWORDPRG
   :formatprg vim.env.NVIM_FORMATPRG})

(fn read-path-list []
  "Returns a list of paths from the NVIM_PATH_LIST env variable iff the env variable is not null"
  (when vim.env.NVIM_PATH_LIST
    (core.concat ["." ""] (string.split vim.env.NVIM_PATH_LIST ":"))))

(fn load-env []
  (core.merge! vim.opt (read-env-pairs))
  (-?>> (read-path-list)
        (set vim.opt.path)))

{:setup load-env : read-path-list : load-env}
