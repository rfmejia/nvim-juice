(local {: autoload} (require :nfnl.module))
(local {: blank?} (autoload :nfnl.string))
(local {: nmap : set-opts} (autoload :juice.util))

(set-opts {:shiftwidth 2 :tabstop 2 :expandtab true :textwidth 100})

(fn format-fennel [path]
  (let [filename (if (blank? path)
                     (vim.fn.expand "%:p")
                     path)]
    (vim.fn.system [:fnlfmt :--fix filename])))

(nmap :<localleader>cf (fn []
                         (->> (vim.fn.expand "%:p")
                              (format-fennel))))
