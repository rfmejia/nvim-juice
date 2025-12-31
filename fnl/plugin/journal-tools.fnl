(fn bind-journal-maps [journal-tools]
  [[:n
    :<localleader>w
    journal-tools.insert-week
    {:desc "[journal] insert current week as an h2 header"
     :buffer true
     :silent true}]
   [:n
    :<localleader>d
    journal-tools.insert-day
    {:desc "[journal] insert current date as an h3 header"
     :buffer true
     :silent true}]
   [:n
    :<localleader>t
    journal-tools.insert-time
    {:desc "[journal] insert current time as an h4 header"
     :buffer true
     :silent true}]
   [:n
    :<localleader>x
    journal-tools.insert-task
    {:desc "[journal] insert current time as an h4 header"
     :buffer true
     :silent true}]])

(fn init-plugin []
  (vim.cmd.packadd :journal-tools)
  (let [{: autoload} (require :nfnl.module)
        journal-tools (autoload :journal-tools)
        keymaps (bind-journal-maps journal-tools)]
    (journal-tools.register-tools {:maps keymaps})
    (vim.notify "[journal-tools] Loaded tools")))

(vim.api.nvim_create_user_command :JournalInit
                                  (fn []
                                    (vim.api.nvim_del_user_command :JournalInit)
                                    (init-plugin)
                                    )
                                  {:desc "Load default mappings for journal tools"})
