(fn git-file-status []
  "Updates the git flag(s) of the current file inside g:gitfile"
  (let [path (vim.fn.expand "%:p")
        git-cmd (.. "git file-status " path " | tr -d ' \\n'")]
    (comment "TODO Check: if directory then set to blank")
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

(fn count-diagnostic [severity]
  "Returns 'n! ' where n is the number of diagnostic messages, otherwise an empty string"
  (let [a (require :nfnl.core)
        count (a.count (vim.diagnostic.get 0 {: severity}))]
    (if (> count 0)
        (.. count "! ") "")))

(fn build-statusline [widgets]
  "Creates a vim statusline string, inserting optional widgets defined as a list of strings"
  (let [s (require :nfnl.string)
        u (require :juice.util)
        filename "%f"
        buffer-modified-flags "%m"
        buffer-type-flags "%q%h%r"
        git-status " %{g:git_file_status}"
        git-branch " %{g:git_branch}"
        align-right "%="
        errors (u.lua-statusline "require('juice.statusline')['count-diagnostic'](vim.diagnostic.severity.ERROR)")
        warnings (u.lua-statusline "require('juice.statusline')['count-diagnostic'](vim.diagnostic.severity.WARN)")
        ruler "%l:%c"
        widget-str (.. " " (s.join widgets) " ")
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
                  errors
                  warn-color
                  warnings
                  info-color
                  git-branch
                  " "
                  default-color
                  ruler]
        statusline (s.join template)]
    statusline))

{: git-file-status : git-branch : count-diagnostic : build-statusline}
