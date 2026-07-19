(vim.pack.add ["https://github.com/tpope/vim-dadbod"
               "https://github.com/kristijanhusak/vim-dadbod-completion"])

(let [{: autoload} (require :nfnl.module)
      util (autoload :juice.util)
      dadbod-maps [[:n
                    "<localleader>e;"
                    ":DB g:db "
                    {:desc "[dadbod] run an sql statement in command mode"
                     :noremap true
                     :buffer true}]
                   [:n
                    :<localleader>ee
                    ":.DB g:db<cr>"
                    {:desc "[dadbod] run line as an sql statement"
                     :noremap true
                     :buffer true}]
                   [:n
                    :<localleader>ep
                    "vip:DB g:db<cr>"
                    {:desc "[dadbod] run paragraph as an sql statement"
                     :noremap true
                     :buffer true}]
                   [:n
                    :<localleader>eb
                    ":%DB g:db<cr>"
                    {:desc "[dadbod] run buffer as sql statements"
                     :noremap true
                     :buffer true}]]
      ft-autocmd-opts (fn [filetypes env-var group-name]
                        "Create FileType autocmd options to load if an environment variable is defined"
                        {:pattern filetypes
                         :callback #(when env-var
                                      (util.set-keys dadbod-maps)
                                      (pcall vim.cmd.DB (.. "g:db = " env-var))
                                      (set vim.opt_local.omnifunc
                                           "vim_dadbod_completion#omni")
                                      (vim.print "[dadbod] Connected to database"))
                         :group :dbmode})]
  (vim.api.nvim_create_augroup :dbmode {:clear true})
  (vim.api.nvim_create_autocmd :FileType
                               (ft-autocmd-opts [:sql :mysql :pgsql]
                                                vim.env.DADBOD_MYSQL_DB))
  (vim.api.nvim_create_autocmd :FileType
                               (ft-autocmd-opts :redis vim.env.DADBOD_REDIS_DB)))
