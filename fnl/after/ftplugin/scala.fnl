(local {: autoload} (require :nfnl.module))
(local {: blank?} (autoload :nfnl.string))
(local {: nmap : set-opts : user-command} (autoload :juice.util))

(set-opts {:shiftwidth 2
           :tabstop 2
           :expandtab true
           :textwidth 100
           :signcolumn "yes:1"
           ; FIXME This doesn't seem to be reflected
           "indentkeys:remove" ["<>>"]})

(fn run-scalafmt [path]
  (let [filename (if (blank? path) (vim.fn.expand "%:p") path)]
    (vim.fn.system [:scalafmt
                    :--mode
                    :changed
                    :--config
                    :.scalafmt.conf
                    filename
                    filename])))

(user-command :ScalafmtApply (fn [] (run-scalafmt)) {:bang true})

(nmap :<localleader>cf (fn [] (run-scalafmt (vim.fn.expand "%:p")))
      [:noremap :nowait :silent])

(nmap :<localleader>s "vip:sort<cr>" [:noremap :nowait :silent])
