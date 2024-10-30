(local {: autoload} (require :nfnl.module))
(local notify (autoload :nfnl.notify))
(local util (autoload :juice.util))

(fn insert-week []
  (lambda find-day [dir day new-time]
    (let [new-day (vim.fn.strftime "%a" new-time)
          secs-in-a-day (* 60 60 24)]
      (if (= day new-day) (vim.fn.strftime "%b %d" new-time)
          (find-day dir day
                    (if (= dir :fwd) (+ new-time secs-in-a-day)
                        (- new-time secs-in-a-day))))))
  (let [week-num (vim.fn.strftime "%U")
        week-start (find-day :back :Mon (vim.fn.localtime))
        week-end (find-day :fwd :Sun (vim.fn.localtime))
        text (.. "## Week " week-num " (" week-start " to " week-end ")")]
    (util.insert-lines "----" "" text "")))

(fn insert-day []
  (let [curr-day (vim.fn.strftime "%a, %d %b %Y")
        text (.. "### " curr-day)]
    (util.insert-lines text)))

(fn insert-time []
  (let [curr-time (vim.fn.strftime "%H:%M")
        text (.. "#### " curr-time " ")]
    (util.insert-lines text)))

(fn insert-task [] (util.insert-lines "- [ ] "))

(fn load-journal-tools []
  (local mappings (autoload :juice.mappings))
  (mappings.set-journal-maps)
  ;; Load mappings the first time
  (vim.api.nvim_create_autocmd :FileType
                               {:pattern :markdown
                                :callback #(mappings.set-journal-maps)})
  (vim.api.nvim_del_user_command :JournalInit)
  (notify.info "Loaded journal tools"))

(fn setup []
  (vim.api.nvim_create_user_command :JournalInit load-journal-tools
                                    {:desc "Load default mappings for journal tools"}))

{: setup
 : insert-week
 : insert-day
 : insert-time
 : insert-task
 : load-journal-tools}
