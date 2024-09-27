(local {: autoload} (require :nfnl.module))
(local util (autoload :juice.util))

(util.assoc-in vim.opt {:shiftwidth 2
                        :tabstop 2
                        :expandtab true
                        :textwidth 100
                        :spell false
                        :commentstring ";; %s"})

(vim.api.nvim_create_autocmd :BufWritePre
                             {:callback #(vim.lsp.buf.format {:async false})
                              :desc :vim.lsp.buf.format
                              :pattern [:*.clj :*.edn]
                              :group (vim.api.nvim_create_augroup :format_group
                                                                  {:clear true})})
