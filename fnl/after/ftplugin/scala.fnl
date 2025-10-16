(local {: autoload} (require :nfnl.module))
(local notify (autoload :nfnl.notify))
(local scalametals (autoload :juice.lsp.scalametals))
(local str (autoload :nfnl.string))
(local core (autoload :nfnl.core))
(local util (autoload :juice.util))

(core.merge! vim.opt_local {:shiftwidth 2
                            :tabstop 2
                            :expandtab true
                            :textwidth 100
                            :signcolumn "yes:1"})

(vim.opt_local.indentkeys:remove "<>>")

(vim.keymap.set :n :<localleader>s "vip:sort<cr>"
                {:desc "[scala] sort in paragraph"
                 :nowait true
                 :buffer true
                 :silent true})

(when (util.executable? :sbtn)
  (vim.keymap.set :n :<leader>os
                  (fn []
                    (vim.cmd.split "term://sbtn")
                    (vim.api.nvim_win_set_height 0 15)
                    (vim.api.nvim_create_autocmd [:BufWinEnter :WinEnter]
                                                 {:buffer (vim.api.nvim_get_current_buf)
                                                  :callback #(vim.cmd.startinsert)})
                    (vim.cmd.startinsert)))
  (vim.keymap.set :n :<leader>oa ":!tmux split-window -v -l 30\\% sbtn<cr><cr>"
                  {:desc "[scala] open sbtn in a tmux split"
                   :buffer true
                   :silent true}))

(when (util.executable? :scala-cli)
  (vim.keymap.set :n :<leader>oc
                  ":!tmux split-window -v -l 30\\% scala-cli console %<cr><cr>"
                  {:desc "[scala] open scala-cli in a tmux split"
                   :buffer true
                   :silent true}))

(scalametals.initialize-metals)

(fn metals-lsp-started? []
  (accumulate [has-metals? false _ client (ipairs (vim.lsp.get_clients))]
    (or has-metals? (= :metals (?. client :name)))))

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
      (nil err-msg) (notify.error "[scala] Could not run `scalafmt`: " err-msg))))

(vim.api.nvim_buf_create_user_command (vim.api.nvim_get_current_buf)
                                      :ScalafmtApply #(run-scalafmt)
                                      {:bang true})

(if (metals-lsp-started?)
    (vim.keymap.set :n :<localleader>m ":Metals<C-d>"
                    {:desc "[metals] show all commands" :buffer true})
    (util.set-keys [[:n
                     :grf
                     #(run-scalafmt (vim.fn.expand "%:p"))
                     {:desc "[scala] run scalafmt on buffer"
                      :buffer true
                      :nowait true
                      :silent true}]
                    [:n
                     :<localleader>m
                     (fn []
                       (util.call :metals :start_server)
                       (core.println "Starting Metals server")
                       (vim.keymap.set :n :<localleader>m ":Metals<C-d>"
                                       {:desc "[metals] show all commands"
                                        :buffer true}))
                     {:desc "[metals] show all commands"
                      :buffer true
                      :silent false}]]))
