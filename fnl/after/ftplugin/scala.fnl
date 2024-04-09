(local {: autoload} (require :nfnl.module))
(local {: blank?} (autoload :nfnl.string))
(local {: nmap : user-command} (autoload :juice.util))

(set vim.opt.shiftwidth 2)
(set vim.opt.tabstop 2)
(set vim.opt.expandtab true)
(set vim.opt.textwidth 100)
(set vim.opt.signcolumn "yes:1")
(comment "FIXME This doesn't seem to be reflected"
  (vim.opt.indentkeys:remove "<>>"))

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
