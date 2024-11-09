(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))
(local notify (autoload :nfnl.notify))
(local util (autoload :juice.util))

(local default-opts {:day-format "%a, %d %b %Y"
                     :time-format "%H:%M"
                     :task-format "* [ ] "
                     :maps nil})

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
  (let [day-format (. vim.g.journal_tools :day-format)
        curr-day (vim.fn.strftime day-format)
        text (.. "### " curr-day)]
    (util.insert-lines text)))

(fn insert-time []
  (let [time-format (. vim.g.journal_tools :time-format)
        curr-time (vim.fn.strftime time-format)
        text (.. "#### " curr-time " ")]
    (util.insert-lines text)))

(fn insert-task []
  (->> (. vim.g.journal_tools :task-format)
       (util.insert-lines)))

(fn load-journal-tools [user-opts]
  (let [maps (core.merge (?. user-opts :maps) (. default-opts :maps))
        opts (core.merge default-opts user-opts)]
    ;; Clear maps from opts
    (tset opts :maps nil)
    ;; Load mappings the first time, then add in FileType autocmd
    (util.set-keys maps)
    (vim.api.nvim_create_autocmd :FileType
                                 {:pattern :markdown
                                  :callback #(util.set-keys maps)})
    ;; Set global plugin-specific variables
    (set vim.g.journal_tools opts)
    (vim.api.nvim_del_user_command :JournalInit)
    (notify.info "[journal-tools] Loaded tools")))

(fn setup [opts]
  (vim.api.nvim_create_user_command :JournalInit #(load-journal-tools opts)
                                    {:desc "Load default mappings for journal tools"}))

{: setup
 : insert-week
 : insert-day
 : insert-time
 : insert-task
 : load-journal-tools}
