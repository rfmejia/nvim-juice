(local {: autoload} (require :nfnl.module))
(local {: bufmap : set-opts} (autoload :juice.util))

(set-opts {:shiftwidth 2
           :tabstop 2
           :expandtab true
           :textwidth 100
           :commentstring ";; %s"})

(vim.api.nvim_create_autocmd :BufWritePre
                             {:callback #(vim.lsp.buf.format {:async false})
                              :desc :vim.lsp.buf.format
                              :pattern [:*.clj :*.edn]
                              :group (vim.api.nvim_create_augroup :format_group
                                                                  {:clear true})})
