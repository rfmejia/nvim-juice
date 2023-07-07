(module statusline
  {autoload {a aniseed.core
             s aniseed.string}})

(defn git-file-status []
  "Returns the git flag(s) of the current file"
  (let [path (vim.fn.expand "%:p")
        git-cmd (.. "git file-status " path " | tr -d '\n'")
        status (s.trim (vim.fn.system git-cmd))]
    (if (not (s.blank? status))
      (.. " " status " ")
      "")
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
        lua-eval (lambda [command] (string.format "%%{luaeval(\"%s\")}" command))
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
    statusline))
