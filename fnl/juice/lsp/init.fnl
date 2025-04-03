(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))
(local lspconfig (autoload :lspconfig))
(local util (autoload :juice.util))

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
  (let [omnifunc-map [[:i :<C-space> :<C-x><C-o> {:buffer bufnr}]]
        goto-maps [[:n
                    :gd
                    vim.lsp.buf.definition
                    {:desc "goto definition" :nowait true :buffer bufnr}]
                   [:n
                    :gt
                    vim.lsp.buf.type_definition
                    {:desc "goto type definition" :nowait true :buffer bufnr}]
                   (comment [:n
                             :gri
                             vim.lsp.buf.implementation
                             {:desc "goto implementation" :buffer bufnr}])
                   (comment [:n
                             :grr
                             vim.lsp.buf.references
                             {:desc "goto references" :buffer bufnr}])
                   (comment [:n
                             :gO
                             vim.lsp.buf.document_symbol
                             {:desc "goto symbol" :buffer bufnr}])
                   [:n
                    :gW
                    vim.lsp.buf.workspace_symbol
                    {:desc "(g)oto (W)orkspace symbol" :buffer bufnr}]]
        diagnostic-maps [[:n
                          :<localleader>de
                          #(vim.diagnostic.setqflist {:severity vim.diagnostic.severity.ERROR})
                          {:desc "show (d)iagnostic (e)rrors of the workspace in quickfix list"
                           :buffer bufnr}]
                         [:n
                          :<localleader>dw
                          vim.diagnostic.setqflist
                          {:desc "show (d)iagnostics of the (w)orkspace in quickfix list"
                           :buffer bufnr}]
                         [:n
                          :<localleader>db
                          vim.diagnostic.setloclist
                          {:desc "show (d)iagnostics of the (b)uffer in local list"
                           :buffer bufnr}]
                         (comment [:n
                                   "[d"
                                   #(vim.diagnostic.goto_prev {:wrap false})
                                   {:desc "goto next diagnostic" :buffer bufnr}])
                         (comment [:n
                                   "]d"
                                   #(vim.diagnostic.goto_next {:wrap false})
                                   {:desc "goto previous diagnostic"
                                    :buffer bufnr}])]
        code-action-maps [(comment [[:n :v]
                                    :gra
                                    vim.lsp.buf.code_action
                                    {:desc "code actions" :buffer bufnr}])
                          (comment [:n
                                    :<C-s>
                                    vim.lsp.buf.signature_help
                                    {:desc "code signature" :buffer bufnr}])
                          (comment [:n
                                    :grn
                                    vim.lsp.buf.rename
                                    {:desc "code identifier rename"
                                     :buffer bufnr}])
                          [:n
                           :<localleader>cf
                           #(vim.lsp.buf.format {:async true})
                           {:desc "code format" :buffer bufnr}]]
        mappings (core.concat omnifunc-map goto-maps diagnostic-maps
                              code-action-maps)]
    (util.set-keys mappings)))

(lambda count-diagnostic [?bufnr severity]
  "Returns 'n! ' where n is the number of diagnostic messages, otherwise an empty string"
  (-> ?bufnr
      (vim.diagnostic.get {: severity})
      (core.count)))

(fn setup []
  (let [scalametals (autoload :juice.lsp.scalametals)
        diagnostic-config {:virtual_text true}
        go-settings {:gopls {:analyses {:unusedparams true} :staticcheck true}}]
    (comment vim.diagnostic.config diagnostic-config)
    (scalametals.register-init-command)
    (lspconfig.ts_ls.setup {:on_attach set-buffer-opts : handlers})
    (lspconfig.jdtls.setup {:on_attach set-buffer-opts : handlers})
    (lspconfig.clojure_lsp.setup {:on_attach set-buffer-opts : handlers})
    (lspconfig.gopls.setup {:on_attach set-buffer-opts
                            : go-settings
                            : handlers})))

{: count-diagnostic : handlers : set-buffer-opts : setup}
