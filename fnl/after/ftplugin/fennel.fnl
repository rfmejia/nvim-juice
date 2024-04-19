(local {: autoload} (require :nfnl.module))
(local {: blank?} (autoload :nfnl.string))
(local {: nmap : set-opts} (autoload :juice.util))

(set-opts {:shiftwidth 2 :tabstop 2 :expandtab true :textwidth 100})

(lambda buffer-is-modified [buf-num]
  (vim.api.nvim_buf_get_option buf-num :modified))

(lambda format-fennel [path]
  (let [modified (buffer-is-modified (vim.api.nvim_get_current_buf))
        fnlfmt-cmd [:fnlfmt :--fix path]]
    (if (not modified)
        (match (vim.fn.system fnlfmt-cmd)
          ok (vim.cmd :e!)
          (nil err-msg) (print "Could not run `fnlfmt`: " err-msg))
        (error "fnlfmt: cannot format a modified buffer"))))

(nmap :<localleader>cf (fn [] (format-fennel (vim.fn.expand "%:p"))) [:buffer])
