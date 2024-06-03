(local {: autoload} (require :nfnl.module))
(local {: count} (autoload :nfnl.core))
(local lspconfig (autoload :lspconfig))
(local {: bufmap} (autoload :juice.util))

(local handlers
       {:textDocument/publishDiagnostics (vim.lsp.with vim.lsp.diagnostic.on_publish_diagnostics
                                           {:underline [vim.diagnostic.severity.WARN]
                                            :update_in_insert true
                                            :virtual_text {}
                                            :signs false
                                            :float {:border :rounded}})
        :textDocument/hover (vim.lsp.with vim.lsp.handlers.hover
                              {:border :rounded})
        :textDocument/signature_help (vim.lsp.with vim.lsp.handlers.signature_help
                                       {:border :rounded})})

(lambda set-buffer-opts [_ bufnr]
  "Buffer-specific lsp options"
  (set vim.opt.omnifunc "v:lua.vim.lsp.omnifunc")
  (let [omnifunc-map {:i {:<C-space> [:<C-x><C-o> [:noremap :silent]]}}
        goto-maps {:n {:gd [vim.lsp.buf.definition
                            [:noremap :silent :nowait]
                            "(g)oto (d)efinition"]
                       :gt [vim.lsp.buf.type_definition
                            [:noremap :silent :nowait]
                            "(g)oto (t)ype definition"]
                       :gi [vim.lsp.buf.implementation
                            [:noremap :silent]
                            "(g)oto (i)mplementation"]
                       :gr [vim.lsp.buf.references
                            [:noremap :silent]
                            "(g)oto (r)eferences"]
                       :gs [vim.lsp.buf.document_symbol
                            [:noremap :silent]
                            "(g)oto (s)ymbol"]
                       :gS [vim.lsp.buf.workspace_symbol
                            [:noremap :silent]
                            "(g)oto workspace (S)ymbol"]}}
        diagnostic-maps {:n {:<localleader>de [#(vim.diagnostic.setqflist {:severity vim.diagnostic.severity.ERROR})
                                               [:noremap :silent]
                                               "show (d)iagnostic (e)rrors of the workspace in quickfix list"]
                             :<localleader>dw [vim.diagnostic.setqflist
                                               [:noremap :silent]
                                               "show (d)iagnostics of the (w)orkspace in quickfix list"]
                             :<localleader>db [vim.diagnostic.setloclist
                                               [:noremap :silent]
                                               "show (d)iagnostics of the (b)uffer in local list"]
                             "[d" [#(vim.diagnostic.goto_prev {:wrap false})
                                   [:noremap :silent]
                                   "goto next diagnostic"]
                             "]d" [#(vim.diagnostic.goto_next {:wrap false})
                                   [:noremap :silent]
                                   "goto previous diagnostic"]}}
        code-action-maps {:n {:<localleader>ca [vim.lsp.buf.code_action
                                                [:noremap :silent]
                                                "(c)ode (a)ctions"]
                              :<localleader>cs [vim.lsp.buf.signature_help
                                                [:noremap :silent]
                                                "(c)ode (s)ignature"]
                              :<localleader>cr [vim.lsp.buf.rename
                                                [:noremap]
                                                "(c)ode identifier (r)ename"]
                              :<localleader>cf [#(vim.lsp.buf.format {:async true})
                                                [:noremap :silent]
                                                "(c)ode (f)ormat"]}}] ; TODO loop through
    (each [_ mappings (ipairs [omnifunc-map
                               goto-maps
                               diagnostic-maps
                               code-action-maps])]
      (bufmap bufnr mappings))))

(lambda count-diagnostic [?bufnr severity]
  "Returns 'n! ' where n is the number of diagnostic messages, otherwise an empty string"
  (-> ?bufnr
      (vim.diagnostic.get {: severity})
      (count)))

(fn setup []
  (let [scalametals (autoload :juice.lsp.scalametals)]
    (scalametals.register-init-command)
    (lspconfig.clojure_lsp.setup {:on_attach set-buffer-opts : handlers})
    (let [settings {:gopls {:analyses {:unusedparams true} :staticcheck true}}]
      (lspconfig.gopls.setup {:on_attach set-buffer-opts : settings : handlers}))))

{: count-diagnostic : handlers : set-buffer-opts : setup}
