(local {: autoload} (require :nfnl.module))
(local util (autoload :juice.util))

(util.set-opts {:shiftwidth 2
                :tabstop 2
                :expandtab true
                :textwidth 100
                :commentstring ";; %s"})

(lambda buffer-is-modified [buf-num]
  (vim.api.nvim_buf_get_option buf-num :modified))

(lambda format-fennel [path]
  (let [modified (buffer-is-modified (vim.api.nvim_get_current_buf))
        fnlfmt-cmd [:fnlfmt :--fix path]]
    (if (not modified)
        (match (vim.fn.system fnlfmt-cmd)
          _ (vim.cmd :e!)
          (nil err-msg) (print "Could not run `fnlfmt`: " err-msg))
        (error "fnlfmt: cannot format a modified buffer"))))

(vim.keymap.set :n :<localleader>cf #(format-fennel (vim.fn.expand "%:p"))
                {:noremap true :silent true :desc "(c)ode (f)ormat"})

(vim.api.nvim_buf_create_user_command 0 :FnlFmt
                                      #(format-fennel (vim.fn.expand "%:p"))
                                      {:bang true})

(vim.api.nvim_create_autocmd :BufWritePost
                             {:callback #(format-fennel (vim.fn.expand "%:p"))
                              :buffer (vim.api.nvim_get_current_buf)
                              :desc "Format on buffer write"
                              :group (vim.api.nvim_create_augroup :format_group
                                                                  {:clear true})})
