(local {: autoload} (require :nfnl.module))
(local util (autoload :juice.util))

(let [opts {:day-format "%a, %d %b %Y"
            :time-format "%H:%M"
            :task-format "* [ ] "
            :maps nil}
      insert-week (fn []
                    (lambda find-day [dir day new-time]
                      (let [new-day (vim.fn.strftime "%a" new-time)
                            secs-in-a-day (* 60 60 24)]
                        (if (= day new-day)
                            (vim.fn.strftime "%b %d" new-time)
                            (find-day dir day
                                      (if (= dir :fwd)
                                          (+ new-time secs-in-a-day)
                                          (- new-time secs-in-a-day))))))
                    (let [week-num (vim.fn.strftime "%U")
                          week-start (find-day :back :Mon (vim.fn.localtime))
                          week-end (find-day :fwd :Sun (vim.fn.localtime))
                          text (.. "----" "\n\n" "## Week " week-num " ("
                                   week-start " to " week-end ")" "\n\n")]
                      (vim.api.nvim_paste text false -1)))
      insert-day (fn []
                   (let [day-format (. vim.g.journal_tools :day-format)
                         curr-day (vim.fn.strftime day-format)
                         text (.. "### " curr-day "\n\n")]
                     (vim.api.nvim_paste text false -1)))
      insert-time (fn []
                    (let [time-format (. vim.g.journal_tools :time-format)
                          curr-time (vim.fn.strftime time-format)
                          text (.. "#### " curr-time " ")]
                      (vim.api.nvim_paste text false -1)
                      (vim.cmd :startinsert!)))
      insert-task (fn []
                    (vim.api.nvim_paste (. vim.g.journal_tools :task-format)
                                        false -1)
                    (vim.cmd :startinsert!))
      keymaps [[:n
                :<localleader>w
                insert-week
                {:desc "[journal] insert current week as an h2 header"
                 :buffer true
                 :silent true}]
               [:n
                :<localleader>d
                insert-day
                {:desc "[journal] insert current date as an h3 header"
                 :buffer true
                 :silent true}]
               [:n
                :<localleader>t
                insert-time
                {:desc "[journal] insert current time as an h4 header"
                 :buffer true
                 :silent true}]
               [:n
                :<localleader>x
                insert-task
                {:desc "[journal] insert current time as an h4 header"
                 :buffer true
                 :silent true}]]]
  (set vim.g.journal_tools opts)
  (vim.api.nvim_create_autocmd :FileType
                               {:pattern :markdown
                                :callback #(util.set-keys keymaps)}))
