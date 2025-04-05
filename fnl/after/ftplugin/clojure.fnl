(local {: autoload} (require :nfnl.module))
(local lspconfig (autoload :lspconfig))
(local util (autoload :juice.util))

(util.assoc-in vim.opt_local
               {:shiftwidth 2
                :tabstop 2
                :expandtab true
                :textwidth 100
                :spell false
                :commentstring ";; %s"})

(vim.api.nvim_create_autocmd :BufWritePre
                             {:pattern [:*.clj :*.edn]
                              :callback #(vim.lsp.buf.format {:async false})
                              :desc "[clojure] call vim.lsp.buf.format on save"
                              :group (vim.api.nvim_create_augroup :format_group
                                                                  {:clear true})})

(lspconfig.clojure_lsp.setup {})
