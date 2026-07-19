(local {: autoload} (require :nfnl.module))
(local notify (autoload :nfnl.notify))
(local core (autoload :nfnl.core))
(local util (autoload :juice.util))

(core.merge! vim.opt_local {:shiftwidth 2
                            :tabstop 2
                            :expandtab true
                            :textwidth 80
                            :commentstring ";; %s"})

(lambda buffer-is-modified [buf-num]
  (vim.api.nvim_get_option_value :modified {:buf buf-num}))

(lambda format-fennel [path]
  (if (buffer-is-modified (vim.api.nvim_get_current_buf))
      (notify.error "fnlfmt: cannot format a modified buffer")
      (case (vim.fn.system [:fnlfmt :--fix path])
        _ (vim.cmd :e!)
        (nil err-msg) (notify.error "[fennel] Could not run `fnlfmt`: " err-msg))))

(vim.keymap.set :n :grf #(format-fennel (vim.fn.expand "%:p"))
                {:desc "[fennel] (c)ode (f)ormat" :buffer true})

(vim.api.nvim_buf_create_user_command 0 :FnlFmt
                                      #(format-fennel (vim.fn.expand "%:p"))
                                      {:bang true})

(vim.api.nvim_create_autocmd :BufWritePost
                             {:callback #(format-fennel (vim.fn.expand "%:p"))
                              :buffer (vim.api.nvim_get_current_buf)
                              :desc "format on buffer write"
                              :group (vim.api.nvim_create_augroup :format_group
                                                                  {:clear true})})
