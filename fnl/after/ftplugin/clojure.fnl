(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))

(core.merge! vim.opt_local {:shiftwidth 2
                            :tabstop 2
                            :expandtab true
                            :textwidth 80
                            :commentstring ";; %s"})

(vim.api.nvim_create_autocmd :BufWritePre
                             {:pattern [:*.clj :*.cljs :*.edn]
                              :callback vim.lsp.buf.format
                              :desc "[clojure] call vim.lsp.buf.format on save"
                              :group (vim.api.nvim_create_augroup :format_group
                                                                  {:clear true})})
