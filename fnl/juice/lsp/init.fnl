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
                    {:desc "(g)oto (d)efinition" :nowait true :buffer bufnr}]
                   [:n
                    :gt
                    vim.lsp.buf.type_definition
                    {:desc "(g)oto (t)ype definition"
                     :nowait true
                     :buffer bufnr}]
                   [:n
                    :gi
                    vim.lsp.buf.implementation
                    {:desc "(g)oto (i)mplementation" :buffer bufnr}]
                   [:n
                    :gr
                    vim.lsp.buf.references
                    {:desc "(g)oto (r)eferences" :buffer bufnr}]
                   [:n
                    :gs
                    vim.lsp.buf.document_symbol
                    {:desc "(g)oto (s)ymbol" :buffer bufnr}]
                   [:n
                    :gS
                    vim.lsp.buf.workspace_symbol
                    {:desc "(g)oto workspace (S)ymbol" :buffer bufnr}]]
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
                         [:n
                          "[d"
                          #(vim.diagnostic.goto_prev {:wrap false})
                          {:desc "goto next diagnostic" :buffer bufnr}]
                         [:n
                          "]d"
                          #(vim.diagnostic.goto_next {:wrap false})
                          {:desc "goto previous diagnostic" :buffer bufnr}]]
        code-action-maps [[:n
                           :<localleader>ca
                           vim.lsp.buf.code_action
                           {:desc "(c)ode (a)ctions" :buffer bufnr}]
                          [:n
                           :<localleader>cs
                           vim.lsp.buf.signature_help
                           {:desc "(c)ode (s)ignature" :buffer bufnr}]
                          [:n
                           :<localleader>cr
                           vim.lsp.buf.rename
                           {:desc "(c)ode identifier (r)ename" :buffer bufnr}]
                          [:n
                           :<localleader>cf
                           #(vim.lsp.buf.format {:async true})
                           {:desc "(c)ode (f)ormat" :buffer bufnr}]]
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
        go-settings {:gopls {:analyses {:unusedparams true} :staticcheck true}}]
    (scalametals.register-init-command)
    (lspconfig.clojure_lsp.setup {:on_attach set-buffer-opts : handlers})
    (lspconfig.gopls.setup {:on_attach set-buffer-opts
                            : go-settings
                            : handlers})))

{: count-diagnostic : handlers : set-buffer-opts : setup}
