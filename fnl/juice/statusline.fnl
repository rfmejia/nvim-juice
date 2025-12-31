(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))
(local str (autoload :nfnl.string))

(lambda wrap-luaeval [command]
  "Wraps a Lua command string in vim statusline string"
  (string.format "%%{luaeval(\"%s\")}" command))

(lambda count-diagnostic [?bufnr severity]
  (core.count (vim.diagnostic.get ?bufnr {: severity})))

(lambda count-warnings []
  (case (count-diagnostic 0 vim.diagnostic.severity.WARN)
    0 ""
    count (.. "W:" count " ")))

(lambda count-errors []
  (let [severity vim.diagnostic.severity.ERROR
        ws-err (count-diagnostic nil severity)
        buf-err (count-diagnostic 0 severity)]
    (case ws-err
      0 ""
      _ (.. "E:" buf-err "/" ws-err " "))))

(lambda get-global-var [name]
  (case (pcall vim.api.nvim_get_var name)
    (true value) value
    (false _) nil))

(fn build [widgets]
  "Creates a vim statusline string, inserting optional widgets defined as a list of strings"
  (let [filename "%f"
        buffer-modified-flags "%m"
        buffer-type-flags "%q%h%r"
        git-status (wrap-luaeval "require('juice.statusline')['get-global-var']('git_file_status')")
        git-branch (wrap-luaeval "require('juice.statusline')['get-global-var']('git_branch')")
        align-right "%="
        buf-warnings (wrap-luaeval "require('juice.statusline')['count-warnings'](vim.api.nvim_get_current_buf())")
        ws-errors (wrap-luaeval "require('juice.statusline')['count-errors']()")
        ruler "%l:%c"
        widget-str (.. " " (str.join widgets) " ")
        default-color "%#StatusLine#"
        info-color "%#StatusLineInfo#"
        error-color "%#StatusLineError#"
        warn-color "%#StatusLineWarn#"
        template [filename
                  buffer-modified-flags
                  info-color
                  git-status
                  default-color
                  buffer-type-flags
                  align-right
                  info-color
                  widget-str
                  error-color
                  ws-errors
                  warn-color
                  buf-warnings
                  info-color
                  git-branch
                  default-color
                  " "
                  ruler]]
    (str.join template)))

{: build : count-warnings : count-errors : get-global-var}
