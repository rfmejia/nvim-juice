(vim.pack.add ["https://github.com/tpope/vim-dadbod"
               "https://github.com/kristijanhusak/vim-dadbod-completion"])

(let [{: autoload} (require :nfnl.module)
      util (autoload :juice.util)
      dadbod-maps [[:n
                    "<localleader>d;"
                    ":DB g:db "
                    {:desc "[dadbod] run an sql statement in command mode"
                     :noremap true
                     :buffer true}]
                   [:n
                    :<localleader>dd
                    ":.DB g:db<cr>"
                    {:desc "[dadbod] run line as an sql statement"
                     :noremap true
                     :buffer true}]
                   [:n
                    :<localleader>dp
                    "vip:DB g:db<cr>"
                    {:desc "[dadbod] run paragraph as an sql statement"
                     :noremap true
                     :buffer true}]
                   [:n
                    :<localleader>db
                    ":%DB g:db<cr>"
                    {:desc "[dadbod] run buffer as sql statements"
                     :noremap true
                     :buffer true}]]
      configure (fn []
                  (util.set-keys dadbod-maps)
                  (set vim.opt_local.omnifunc "vim_dadbod_completion#omni")
                  (when vim.env.DADBOD_DEFAULT_DB
                    (vim.cmd.DB (.. "g:db = " vim.env.DADBOD_DEFAULT_DB))))]
  (configure)
  (vim.api.nvim_create_autocmd :FileType
                               {:pattern [:sql :mysql :pgsql]
                                :callback configure}))
