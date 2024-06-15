(local {: autoload} (require :nfnl.module))
(local util (autoload :juice.util))

(util.set-keys [[:n
                 :<localleader>du
                 ":DBUIToggle<cr>"
                 {:desc "toggle dadbod ui"
                  :noremap true
                  :buffer (vim.api.nvim_get_current_buf)}]
                [:n
                 "<localleader>d;"
                 ":DB g:db "
                 {:desc "run an sql statement in command mode"
                  :noremap true
                  :buffer (vim.api.nvim_get_current_buf)}]
                [:n
                 :<localleader>dd
                 ":.DB g:db<cr>"
                 {:desc "run line as an sql statement"
                  :noremap true
                  :buffer (vim.api.nvim_get_current_buf)}]
                [:n
                 :<localleader>dp
                 "vip:DB g:db<cr>"
                 {:desc "run paragraph as an sql statement"
                  :noremap true
                  :buffer (vim.api.nvim_get_current_buf)}]
                [:n
                 :<localleader>db
                 ":%DB g:db<cr>"
                 {:desc "run buffer as sql statements"
                  :noremap true
                  :buffer (vim.api.nvim_get_current_buf)}]])
