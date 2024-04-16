(local {: autoload} (require :nfnl.module))
(local {: blank?} (autoload :nfnl.string))
(local {: nmap : set-opts} (autoload :juice.util))

(set-opts {:shiftwidth 2 :tabstop 2 :expandtab true :textwidth 100})

; TODO check if thu buffer is not dirty before running fnlfmt
(fn format-fennel [path]
  (let [filename (if (blank? path)
                     (vim.fn.expand "%:p")
                     path)
        fnlfmt-cmd [:fnlfmt :--fix filename]]
    (match (vim.fn.system fnlfmt-cmd)
      ok (vim.cmd :e!)
      (nil err-msg) (print "Could not run `fnlfmt`: " err-msg))))

(nmap :<localleader>cf (fn []
                         (->> (vim.fn.expand "%:p")
                              (format-fennel)))
      [:buffer])
