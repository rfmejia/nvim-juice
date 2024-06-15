(local {: autoload} (require :nfnl.module))
(local {: join} (autoload :nfnl.string))
(local {: count-diagnostic} (autoload :juice.lsp))
(local {: lua-statusline} (autoload :juice.util))

(lambda show-diagnostic-count [?buf-num severity]
  (let [count (count-diagnostic ?buf-num severity)
        formatted (if (= count 0) ""
                      (.. count "! "))]
    formatted))

(fn build-statusline [widgets]
  "Creates a vim statusline string, inserting optional widgets defined as a list of strings"
  (let [filename "%f"
        buffer-modified-flags "%m"
        buffer-type-flags "%q%h%r"
        git-status " %{g:git_file_status}"
        git-branch " %{g:git_branch}"
        align-right "%="
        buf-errors (lua-statusline "require('juice.statusline')['show-diagnostic-count'](vim.api.nvim_get_current_buf(), vim.diagnostic.severity.ERROR)")
        buf-warnings (lua-statusline "require('juice.statusline')['show-diagnostic-count'](vim.api.nvim_get_current_buf(), vim.diagnostic.severity.WARN)")
        ruler "%l:%c"
        widget-str (.. " " (join widgets) " ")
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
                  buf-errors
                  warn-color
                  buf-warnings
                  default-color
                  git-branch
                  " "
                  ruler]
        statusline (join template)]
    statusline))

{: build-statusline : show-diagnostic-count}
