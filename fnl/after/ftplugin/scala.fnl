(local {: autoload} (require :nfnl.module))
(local {: blank?} (autoload :nfnl.string))
(local {: executable? : nmap : set-opts : user-command} (autoload :juice.util))

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

(user-command :ScalafmtApply (fn [] (run-scalafmt)) {:bang true})

(nmap :<localleader>cf (fn [] (run-scalafmt (vim.fn.expand "%:p")))
      [:noremap :nowait :silent :buffer])

(nmap :<localleader>s "vip:sort<cr>" [:noremap :nowait :silent :buffer])

(when (executable? :sbtn)
  (nmap :<leader>os ":!tmux split-window -v -l 30\\% sbtn<cr><cr>"
        [:noremap :silent :buffer]))

(when (executable? :scala-cli)
  (nmap :<leader>oc
        ":!tmux split-window -v -l 30\\% scala-cli console %<cr><cr>"
        [:noremap :silent :buffer]))
