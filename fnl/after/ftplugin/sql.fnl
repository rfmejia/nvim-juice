(local {: autoload} (require :nfnl.module))
(local {: bufmap} (autoload :juice.util))

(bufmap (vim.api.nvim_get_current_buf)
        {:n {:<localleader>du [":DBUIToggle<cr>" [:noremap] "toggle dadbod ui"]
             "<localleader>d;" [":DB g:db "
                                [:noremap]
                                "run an sql statement in command mode"]
             :<localleader>dd [":.DB g:db<cr>"
                               [:noremap]
                               "run line as an sql statement"]
             :<localleader>dp ["vip:DB g:db<cr>"
                               [:noremap]
                               "run paragraph as an sql statement"]
             :<localleader>db [":%DB g:db<cr>"
                               [:noremap]
                               "run buffer as sql statements"]}})
