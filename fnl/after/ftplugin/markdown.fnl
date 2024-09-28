(local {: autoload} (require :nfnl.module))
(local util (autoload :juice.util))

(util.assoc-in vim.opt {:shiftwidth 2
                        :tabstop 2
                        :textwidth 100
                        :wrap true
                        :spell true
                        :spelllang :en_us})

(fn render-markdown-to-html [] ; TODO fix and verify this works
  (let [tmp-file (vim.fn.system [:mktemp :--suffix=.html])
        current-file (vim.fn.expand "%:p")]
    (vim.fn.system :$DOTFILES/pandoc/md-to-html current-file tmp-file
                   "&& ${BROWSER}" tmp-file)))

(lambda insert-lines [...]
  "Insert text at the current cursor position"
  (let [buf (vim.api.nvim_get_current_buf)
        (row col) (unpack (vim.api.nvim_win_get_cursor 0))
        _row (- row 1)]
    (vim.api.nvim_buf_set_lines buf _row (+ _row 1) false [...])))

(fn insert-yaml-metadata []
  (let [filename (vim.fn.expand "%:t:r")
        now (vim.fn.strftime "%FT%T%z" (vim.fn.localtime))]
    (insert-lines "---" "title: " filename "created: " now "tags: []" "---")))

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
        text (.. "## Week " week-num " (" week-start " to " week-end ")")]
    (insert-lines "----" "" text "")))

(lambda insert-day []
  (let [curr-day (vim.fn.strftime "%a, %d %b %Y")
        text (.. "### " curr-day)]
    (insert-lines text "")))

(lambda insert-time []
  (let [curr-time (vim.fn.strftime "%H:%M")
        text (.. "#### " curr-time " ")]
    (insert-lines text)))

(lambda insert-task [] (insert-lines "- [ ] "))

(util.set-keys [[:n
                 :<localleader>m
                 insert-yaml-metadata
                 {:desc "insert metadata as a YAML header"
                  :buffer (vim.api.nvim_get_current_buf)
                  :silent true}]
                [:n
                 :<localleader>v
                 render-markdown-to-html
                 {:desc "convert to HTML and show preview in browser"
                  :buffer (vim.api.nvim_get_current_buf)
                  :silent true}]
                [:n
                 :<localleader>w
                 insert-week
                 {:desc "insert current week as an h2 header"
                  :buffer (vim.api.nvim_get_current_buf)
                  :silent true}]
                [:n
                 :<localleader>d
                 insert-day
                 {:desc "insert current date as an h3 header"
                  :buffer (vim.api.nvim_get_current_buf)
                  :silent true}]
                [:n
                 :<localleader>t
                 insert-time
                 {:desc "insert current time as an h4 header"
                  :buffer (vim.api.nvim_get_current_buf)
                  :silent true}]
                [:n
                 :<localleader>x
                 insert-task
                 {:desc "insert current time as an h4 header"
                  :buffer (vim.api.nvim_get_current_buf)
                  :silent true}]])
