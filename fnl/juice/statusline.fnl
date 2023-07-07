(module statusline
  {autoload {a aniseed.core
             s aniseed.string}})

(defn git-file-status []
  (let [path (vim.fn.expand "%:p")
        git-cmd (.. "git file-status " path " | tr -d '\n'")
        status (vim.fn.trim (vim.fn.system git-cmd))]
    (if (not (s.blank? status))
      (.. " " status " ")
      "")
    ))

; returns "n!" or nil if there are no diagnostic messages
(defn count-diagnostic [severity]
  (let [count (a.count (vim.diagnostic.get 0 {:severity severity}))]
    (if (> count 0)
      (.. count "! ")
      "")))

(defn build-statusline [widgets]
  (fn lua-eval [command]
    (string.format "%%{luaeval(\"%s\")}" command))

  (let [filename "%f"
        buffer-modified-flags "%m"
        buffer-type-flags "%q%h%r"
        align-right "%="
        errors (lua-eval "require('juice.statusline')['count-diagnostic'](vim.diagnostic.severity.ERROR)")
        warnings (lua-eval "require('juice.statusline')['count-diagnostic'](vim.diagnostic.severity.WARN)")
        ruler "%l:%c"
        default-color "%#StatusLine#"
        error-color "%#StatusLineError#"
        warn-color "%#StatusLineWarn#"
        template [filename
                  buffer-modified-flags
                  (git-file-status)
                  buffer-type-flags
                  align-right
                  (s.join widgets)
                  error-color errors
                  warn-color warnings
                  default-color ruler]
        statusline (s.join template)]
    ; (print statusline)
    statusline))
