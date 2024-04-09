(local {: autoload} (require :nfnl.module))
(local {: blank?} (require :nfnl.string))
(local {: nmap} (require :juice.util))

(set vim.opt.shiftwidth 2)
(set vim.opt.tabstop 2)
(set vim.opt.expandtab true)
(set vim.opt.textwidth 100)

(fn format-fennel [path]
  (let [filename (if (blank? path)
                     (vim.fn.expand "%:p")
                     path)]
    (vim.fn.system [:fnlfmt :--fix filename])))

(nmap :<localleader>cf (fn []
                         (->> (vim.fn.expand "%:p")
                              (format-fennel))))
