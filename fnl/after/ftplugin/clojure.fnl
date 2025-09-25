(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))

(core.merge! vim.opt_local {:shiftwidth 2
                            :tabstop 2
                            :expandtab true
                            :textwidth 100
                            :spell true
                            :spellfile :clj.en.utf-8.add
                            :commentstring ";; %s"})

(vim.api.nvim_create_autocmd :BufWritePre
                             {:pattern [:*.clj :*.edn]
                              :callback #(vim.lsp.buf.format {:async false})
                              :desc "[clojure] call vim.lsp.buf.format on save"
                              :group (vim.api.nvim_create_augroup :format_group
                                                                  {:clear true})})

(vim.lsp.enable :clojure_lsp)
