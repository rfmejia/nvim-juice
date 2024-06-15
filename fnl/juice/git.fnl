(fn set-file-status-global-var []
  "Updates the git flag(s) of the current file inside g:gitfile"
  (let [path (vim.fn.expand "%:p")
        git-cmd (.. "git file-status " path " | tr -d ' \\n'")]
    (match (vim.fn.system git-cmd)
      status (set vim.g.git_file_status status)
      (nil err-msg) (print "Could not get `git file-status`: " err-msg))))

(fn set-branch-global-var []
  "Set vim.g.git_branch of current working directory (if any)"
  (let [path (vim.fn.expand "%:h")
        git-cmd (.. "git -C " path
                    " branch --show-current --no-color 2> /dev/null | tr -d ' \\n'")]
    (match (vim.fn.system git-cmd)
      branch (set vim.g.git_branch branch)
      (nil err-msg) (print "Could not get `git branch`: " err-msg))))

(fn setup []
  (vim.api.nvim_create_autocmd [:BufEnter :BufWritePost]
                               {:pattern "*"
                                :callback (fn []
                                            (set-file-status-global-var)
                                            (set-branch-global-var))}))

{: setup}
