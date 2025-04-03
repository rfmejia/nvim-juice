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
                           :buffer bufnr}]]
        code-action-maps [[:n
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

(fn setup-autocomplete [ev]
  (let [client (vim.lsp.get_client_by_id ev.data.client_id)]
    (when (: client :supports_method :textDocument/completion)
      (vim.lsp.completion.enable true (. client :id) ev.buf {:autotrigger true}))))

(fn setup []
  (let [scalametals (autoload :juice.lsp.scalametals)
        diagnostic-config {:virtual_text {:current_line true :source true}
                           :severity_sort true}
        go-settings {:gopls {:analyses {:unusedparams true} :staticcheck true}}]
    (vim.diagnostic.config diagnostic-config)
    (vim.api.nvim_create_autocmd :LspAttach {:callback setup-autocomplete})
    (scalametals.register-init-command)
    (lspconfig.ts_ls.setup {:on_attach set-buffer-opts : handlers})
    (lspconfig.jdtls.setup {:on_attach set-buffer-opts : handlers})
    (lspconfig.clojure_lsp.setup {:on_attach set-buffer-opts : handlers})
    (lspconfig.gopls.setup {:on_attach set-buffer-opts
                            : go-settings
                            : handlers})))

{: count-diagnostic : handlers : set-buffer-opts : setup}
