(module statusline
  {autoload {a aniseed.core
             s aniseed.string
             u util}})

; TODO Consider tying this to an autocmd for every BufEnter and writing it to a
; global variable the statusline can read instead
(defn git-file-status []
  "Returns the git flag(s) of the current file"
  (let [path (vim.fn.expand "%:p")
        git-cmd (.. "git file-status " path " | tr -d '\\n'")]
    (match (vim.fn.system git-cmd)
      status (if (not (s.blank? status))
               (.. " " status " ")
               "")
      (nil err-msg) (print "Could not get `git file-status`: " err-msg))
    ))

(defn count-diagnostic [severity]
  "Returns 'n! ' where n is the number of diagnostic messages, otherwise an empty string"
  (let [count (a.count (vim.diagnostic.get 0 {:severity severity}))]
    (if (> count 0)
      (.. count "! ")
      "")))

(defn build-statusline [widgets]
  "Creates a vim statusline string, inserting optional widgets defined as a list of strings"
  (let [filename "%f"
        buffer-modified-flags "%m"
        buffer-type-flags "%q%h%r"
        align-right "%="
        errors (u.lua-statusline "require('juice.statusline')['count-diagnostic'](vim.diagnostic.severity.ERROR)")
        warnings (u.lua-statusline "require('juice.statusline')['count-diagnostic'](vim.diagnostic.severity.WARN)")
        ruler "%l:%c"
        widget-str (.. " " (s.join widgets) " ")
        default-color "%#StatusLine#"
        error-color "%#StatusLineError#"
        warn-color "%#StatusLineWarn#"
        template [filename
                  buffer-modified-flags
                  (git-file-status) ; FIXME Only updated once; might need to update every BufEnter
                  buffer-type-flags
                  align-right
                  widget-str
                  error-color errors
                  warn-color warnings
                  default-color ruler]
        statusline (s.join template)]
    statusline))
