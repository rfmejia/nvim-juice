(fn setup [keymaps default-db]
  (let [{: autoload} (require :nfnl.module)
        util (autoload :juice.util)]
    (util.set-keys keymaps)
    (set vim.opt_local.omnifunc "vim_dadbod_completion#omni")
    (when default-db
      (vim.cmd.DB (.. "g:db = " default-db)))))

(let [{: autoload} (require :nfnl.module)
      packs ["https://github.com/tpope/vim-dadbod"
             "https://github.com/kristijanhusak/vim-dadbod-completion"]
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
                     :buffer true}]]]
  (vim.pack.add packs)
  (setup dadbod-maps vim.env.DADBOD_DEFAULT_DB)
  (vim.api.nvim_create_autocmd :FileType
                               {:pattern [:sql :mysql :pgsql]
                                :callback #(setup dadbod-maps
                                                  vim.env.DADBOD_DEFAULT_DB)}))
