(local {: autoload} (require :nfnl.module))
(local {: join} (autoload :nfnl.string))
(local {: count-diagnostic} (autoload :juice.lsp))
(local {: lua-statusline} (autoload :juice.util))

(fn git-file-status []
  "Updates the git flag(s) of the current file inside g:gitfile"
  (let [path (vim.fn.expand "%:p")
        git-cmd (.. "git file-status " path " | tr -d ' \\n'")]
    (match (vim.fn.system git-cmd)
      status (set vim.g.git_file_status status)
      (nil err-msg) (print "Could not get `git file-status`: " err-msg))))

(fn git-branch []
  "Set vim.g.git_branch of current working directory (if any)"
  (let [path (vim.fn.expand "%:h")
        git-cmd (.. "git -C " path
                    " branch --show-current --no-color 2> /dev/null | tr -d ' \\n'")]
    (match (vim.fn.system git-cmd)
      branch (set vim.g.git_branch branch)
      (nil err-msg) (print "Could not get `git branch`: " err-msg))))

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
                  widget-str
                  error-color
                  buf-errors
                  warn-color
                  buf-warnings
                  info-color
                  git-branch
                  " "
                  default-color
                  ruler]
        statusline (join template)]
    statusline))

{: git-file-status : git-branch : build-statusline : show-diagnostic-count}
