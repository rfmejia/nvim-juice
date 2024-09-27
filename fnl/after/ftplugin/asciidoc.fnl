(local {: autoload} (require :nfnl.module))
(local util (autoload :juice.util))

(util.assoc-in vim.opt {:shiftwidth 2
                        :tabstop 2
                        :textwidth 80
                        :wrap true
                        :spell true
                        :spelllang :en_us})

(fn insert-lines [text]
  "Insert text at the current cursor position"
  (let [buf (vim.api.nvim_get_current_buf)
        (row col) (unpack (vim.api.nvim_win_get_cursor 0))
        _row (- row 1)]
    (vim.api.nvim_buf_set_lines buf _row (+ _row 1) false text)))

(lambda insert-week []
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
        lines ["'''"
               (.. "= Week " week-num " (" week-start " to " week-end ")")
               ""]]
    (insert-lines lines)))

(lambda insert-day []
  (let [curr-day (vim.fn.strftime "%a, %d %b %Y")
        lines [(.. "== " curr-day) ""]]
    (insert-lines lines)))

(lambda insert-time []
  (let [curr-time (vim.fn.strftime "%H:%M")
        lines [(.. "=== " curr-time) ""]]
    (insert-lines lines)))

(lambda insert-task [] (insert-lines ["* [ ] "]))

(comment (insert-week))

(lambda preview-in-browser [in out browser-cmd]
  (if (util.executable? :asciidoctor)
      (match (vim.fn.system [:asciidoctor :-o out in])
        ok (vim.fn.system [browser-cmd out])
        (nil err-msg) (error (.. "Could not run asciidoctor: " err-msg)))))

(when vim.env.BROWSER
  (let [in (vim.fn.expand "%:p")
        out :/tmp/preview.html]
    (vim.keymap.set :n :<localleader>p
                    #(preview-in-browser in out vim.env.BROWSER)
                    {:desc "convert to HTML and show preview in browser"
                     :buffer (vim.api.nvim_get_current_buf)})))

(util.set-keys [[:n
                 :<localleader>w
                 insert-week
                 {:desc "insert current week as an h2 header"
                  :buffer (vim.api.nvim_get_current_buf)
                  :silent true}]
                [:n
                 :<localleader>d
                 ":r!date '+\\%a, \\%d \\%b \\%Y' | xargs -0 printf '\\n== \\%s\\n\\n'<cr>k"
                 {:desc "insert current date as an h2 header"
                  :buffer (vim.api.nvim_get_current_buf)
                  :silent true}]
                [:n
                 :<localleader>t
                 insert-time
                 ;; ":r!date '+\\%H:\\%M' | xargs -0 printf '=== \\%s ' | tr -d '\\n'<cr>A"
                 {:desc "insert current time as an h3 header"
                  :buffer (vim.api.nvim_get_current_buf)
                  :silent true}]
                [:n
                 :<localleader>x
                 insert-task
                 {:desc "insert asciidoc checkbox"
                  :buffer (vim.api.nvim_get_current_buf)
                  :silent true}]])
