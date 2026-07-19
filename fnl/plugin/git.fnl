(vim.pack.add ["https://github.com/lewis6991/gitsigns.nvim"])

(fn set-file-status-global-var! []
  "Updates the git flag(s) of the current file inside g:gitfile"
  (let [path (vim.fn.expand "%:p")
        git-cmd (.. "git file-status " path " | tr -d ' \\n'")]
    (case (vim.fn.system git-cmd)
      status (set vim.g.git_file_status status)
      (nil err-msg)
      (vim.notify (.. "[git-info] Could not get `git file-status`: " err-msg)
                  vim.log.levels.ERROR))))

(fn set-branch-global-var! []
  "Set vim.g.git_branch of current working directory (if any)"
  (let [path (vim.fn.expand "%:h")
        git-cmd (.. "git -C " path
                    " branch --show-current --no-color 2> /dev/null | tr -d ' \\n'")]
    (case (vim.fn.system git-cmd)
      branch (set vim.g.git_branch branch)
      (nil err-msg)
      (vim.notify (.. "[git-info] Could not get `git branch`: " err-msg)
                  vim.log.levels.ERROR))))

(let [{: autoload} (require :nfnl.module)
      core (autoload :nfnl.core)
      gitsigns (autoload :gitsigns)
      util (autoload :juice.util)
      nav-maps [[:n
                 "]g"
                 #(gitsigns.nav_hunk :next
                                     {:wrap false :preview true :target :all})
                 {:desc "[gitsigns] jump to next git hunk"}]
                [:n
                 "[g"
                 #(gitsigns.nav_hunk :prev
                                     {:wrap false :preview true :target :all})
                 {:desc "[gitsigns] jump to previous git hunk"}]]
      toggle-signs #(when (and (gitsigns.toggle_signs $1)
                               (= :no vim.o.signcolumn))
                      (set vim.opt.signcolumn :yes))
      staging-maps [[:n
                     :<localleader>gs
                     gitsigns.stage_hunk
                     {:desc "[gitsigns] (g)it (s)tage hunk"}]
                    [:n
                     :<localleader>gr
                     gitsigns.reset_hunk
                     {:desc "(g)it (r)eset hunk"}]
                    [:n
                     :<localleader>gS
                     gitsigns.stage_buffer
                     {:desc "[gitsigns] (g)it (S)tage buffer"}]
                    [:n
                     :<localleader>gR
                     gitsigns.reset_buffer
                     {:desc "[gitsigns] (g)it (R)eset buffer"}]
                    [:v
                     :<localleader>gs
                     #(gitsigns.stage_hunk {(vim.fn.line ".") (vim.fn.line :v)})
                     {:desc "[gitsigns] (g)it (s)tage hunk"}]
                    [:v
                     :<localleader>gr
                     #(gitsigns.reset_hunk {(vim.fn.line ".") (vim.fn.line :v)})
                     {:desc "[gitsigns] (g)it (r)eset hunk"}]]
      blame-maps [[:n
                   :<localleader>gb
                   #(gitsigns.blame_line {:full true})
                   {:desc "[gitsigns] (g)it show line (b)lame"}]
                  [:n
                   :<localleader>gB
                   gitsigns.toggle_current_line_blame
                   {:desc "[gitsigns] (g)it toggle current line (B)lame"}]]
      view-maps [[:n
                  :<localleader>gt
                  toggle-signs
                  {:desc "[gitsigns] toggle sign visibility"}]
                 [:n
                  :<localleader>gp
                  gitsigns.preview_hunk
                  {:desc "[gitsigns] (g)it (p)review hunk"}]
                 [:n
                  :<localleader>gi
                  gitsigns.preview_hunk_inline
                  {:desc "[gitsigns] (g)it toggle (D)eleted hunks"}]
                 [:n
                  :<localleader>gd
                  gitsigns.diffthis
                  {:desc "[gitsigns] (g)it show (d)iff"}]]
      list-maps [[:n
                  :<localleader>gl
                  gitsigns.setloclist
                  {:desc "[gitsigns] show buffer (g)it hunks in (l)oclist"}]
                 [:n
                  :<localleader>gc
                  #(gitsigns.setqflist :all)
                  {:desc "[gitsigns] show all (g)it hunks in qui(c)kfix list"}]]
      keymaps (core.concat nav-maps staging-maps blame-maps view-maps list-maps)]
  (util.set-keys keymaps)
  (toggle-signs false)
  (vim.api.nvim_create_autocmd [:BufEnter :BufWritePost]
                               {:pattern "*"
                                :callback (fn []
                                            (set-file-status-global-var!)
                                            (set-branch-global-var!))}))
