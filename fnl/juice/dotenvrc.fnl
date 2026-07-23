(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))
(local str (autoload :nfnl.string))

(comment :TODO "Load the following special envs"
  ["split to sbtn or scala-cli" :dadbod])

(fn read-env-pairs []
  "Returns a table of `vim.opt` key and `vim.env` value iff the env variable is not null"
  {:makeprg vim.env.NVIM_MAKEPRG
   :equalprg vim.env.NVIM_EQUALPRG
   :errorformat vim.env.NVIM_ERRORFORMAT
   :keywordprg vim.env.NVIM_KEYWORDPRG
   :formatprg vim.env.NVIM_FORMATPRG
   :wrap (= :true vim.env.NVIM_WRAP)
   :tabstop (tonumber vim.env.NVIM_TABSTOP)
   :textwidth (tonumber vim.env.NVIM_TEXTWIDTH)
   :shiftwidth (tonumber vim.env.NVIM_SHIFTWIDTH)})

(fn read-path-list []
  "Returns a list of paths from the NVIM_PATH_LIST env variable iff the env variable is not null"
  (if vim.env.NVIM_PATH_LIST
      (core.concat ["." ""] (str.split vim.env.NVIM_PATH_LIST ":"))))

(fn load-env []
  (core.merge! vim.opt (read-env-pairs))
  (case (read-path-list)
    path-list (set vim.opt.path path-list)))

{:setup load-env : read-path-list : load-env}
