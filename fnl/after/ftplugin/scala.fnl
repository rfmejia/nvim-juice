(local {: autoload} (require :nfnl.module))
(local {: blank?} (autoload :nfnl.string))
(local {: executable? : bufmap : set-opts} (autoload :juice.util))

(set-opts {:shiftwidth 2
           :tabstop 2
           :expandtab true
           :textwidth 100
           :signcolumn "yes:1"})

(comment "FIXME This doesn't seem to be reflected" "indentkeys:remove" ["<>>"])

(fn run-scalafmt [path]
  (let [filename (if (blank? path) (vim.fn.expand "%:p") path)
        scalafmt-cmd [:scalafmt
                      :--mode
                      :changed
                      :--config
                      :.scalafmt.conf
                      filename
                      filename]]
    (match (vim.fn.system scalafmt-cmd)
      ok (vim.cmd :e!)
      (nil err-msg) (print "Could not run `scalafmt`: " err-msg))))

(vim.api.nvim_buf_create_user_command (vim.api.nvim_get_current_buf)
                                      :ScalafmtApply (fn [] (run-scalafmt))
                                      {:bang true})

(comment "Make sure we respect lsp if it's enabled"
  (bufmap (vim.api.nvim_get_current_buf)
          {:n {:<localleader>cf [(fn [] (run-scalafmt (vim.fn.expand "%:p")))
                                 [:noremap :nowait :silent]
                                 ""]}}))

(bufmap (vim.api.nvim_get_current_buf)
        {:n {:<localleader>s ["vip:sort<cr>"
                              [:noremap :nowait :silent]
                              "sort in paragraph"]}})

(when (executable? :sbtn)
  (bufmap (vim.api.nvim_get_current_buf)
          {:n {:<leader>os [":!tmux split-window -v -l 30\\% sbtn<cr><cr>"
                            [:noremap :silent]
                            "open sbtn in a tmux split"]}}))

(when (executable? :scala-cli)
  (bufmap (vim.api.nvim_get_current_buf)
          {:n {:<leader>oc [":!tmux split-window -v -l 30\\% scala-cli console %<cr><cr>"
                            [:noremap :silent]
                            "open scala-cli in a tmux split"]}}))
