(local u (require :juice.util))

(set vim.opt.shiftwidth 2)
(set vim.opt.tabstop 2)
(set vim.opt.expandtab true)
(set vim.opt.textwidth 100)
(set vim.opt.signcolumn "yes:1")
(vim.opt.indentkeys:remove :<>>) ; FIXME This doesn't seem to be reflected

(fn run-scalafmt [path]
  (let [s (require :nfnl.string)
        filename (if (s.blank? path) (vim.fn.expand "%:p")
                   path)]
    (vim.fn.system ["scalafmt" "--mode" "changed" "--config" ".scalafmt.conf" filename filename]))
  )

(vim.api.nvim_create_user_command :ScalafmtApply (fn [] (run-scalafmt)) {:bang true})
(u.nmap "<localleader>cf" (fn [] (run-scalafmt (vim.fn.expand "%:p"))) [:noremap :nowait :silent])
(u.nmap "<localleader>s" "vip:sort<cr>" [:noremap :nowait :silent])
