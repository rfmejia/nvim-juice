(local {: autoload} (require :nfnl.module))
(local {: bufmap : set-opts} (autoload :juice.util))

(set-opts {:shiftwidth 2 :tabstop 2 :expandtab true :textwidth 100})

(vim.api.nvim_create_autocmd :FileType
                             {:callback (fn []
                                          (set vim.bo.commentstring ";; %s"))
                              :desc "Lisp style line comment"
                              :group (vim.api.nvim_create_augroup :comment_config
                                                                  {:clear true})
                              :pattern [:clojure]})
