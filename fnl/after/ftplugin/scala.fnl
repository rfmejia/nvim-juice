(local {: autoload} (require :nfnl.module))
(local notify (autoload :nfnl.notify))
(local str (autoload :nfnl.string))
(local util (autoload :juice.util))

(util.assoc-in vim.opt {:shiftwidth 2
                        :tabstop 2
                        :expandtab true
                        :textwidth 100
                        :signcolumn "yes:1"})

(comment "FIXME This doesn't seem to be reflected" "indentkeys:remove" ["<>>"])

(fn run-scalafmt [path]
  (let [filename (if (str.blank? path) (vim.fn.expand "%:p") path)
        scalafmt-cmd [:scalafmt
                      :--mode
                      :changed
                      :--config
                      :.scalafmt.conf
                      filename
                      filename]]
    (match (vim.fn.system scalafmt-cmd)
      ok (vim.cmd :e!)
      (nil err-msg) (notify.error "Could not run `scalafmt`: " err-msg))))

(vim.api.nvim_buf_create_user_command (vim.api.nvim_get_current_buf)
                                      :ScalafmtApply #(run-scalafmt)
                                      {:bang true})

(comment "Make sure we respect lsp if it's enabled"
  (vim.keymap.set :n :<localleader>cf #(run-scalafmt (vim.fn.expand "%:p"))
                  {:desc ""
                   :buffer (vim.api.nvim_get_current_buf)
                   :nowait true
                   :silent true}))

(vim.keymap.set :n :<localleader>s "vip:sort<cr>"
                {:desc "sort in paragraph"
                 :nowait true
                 :buffer (vim.api.nvim_get_current_buf)
                 :silent true})

(when (util.executable? :sbtn)
  (vim.keymap.set :n :<leader>os ":!tmux split-window -v -l 30\\% sbtn<cr><cr>"
                  {:desc "open sbtn in a tmux split"
                   :buffer (vim.api.nvim_get_current_buf)
                   :silent true}))

(when (util.executable? :scala-cli)
  (vim.keymap.set :n :<leader>oc
                  ":!tmux split-window -v -l 30\\% scala-cli console %<cr><cr>"
                  {:desc "open scala-cli in a tmux split"
                   :buffer (vim.api.nvim_get_current_buf)
                   :silent true}))
