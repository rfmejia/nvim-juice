(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))
(local util (autoload :juice.util))

(lambda count-diagnostic [?bufnr severity]
  "Returns 'n! ' where n is the number of diagnostic messages, otherwise an empty string"
  (-> ?bufnr
      (vim.diagnostic.get {: severity})
      (core.count)))

(lambda attach-lsp [args]
  (let [client (vim.lsp.get_client_by_id args.data.client_id)
        bufnr args.buf
        omnifunc-map [[:i :<C-space> :<C-x><C-o> {:buffer bufnr}]]
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
                    {:desc "goto Workspace symbol" :buffer bufnr}]]
        diagnostic-maps [[:n
                          :gre
                          #(vim.diagnostic.setqflist {:severity vim.diagnostic.severity.ERROR})
                          {:desc "show diagnostic errors of the workspace in quickfix list"
                           :buffer bufnr}]
                         [:n
                          :grw
                          vim.diagnostic.setqflist
                          {:desc "show diagnostics of the workspace in quickfix list"
                           :buffer bufnr}]
                         [:n
                          :grb
                          vim.diagnostic.setloclist
                          {:desc "show diagnostics of the buffer in local list"
                           :buffer bufnr}]]
        code-action-maps [[:n
                           :grf
                           #(vim.lsp.buf.format {:async true})
                           {:desc "code format" :buffer bufnr}]]
        mappings (core.concat omnifunc-map goto-maps diagnostic-maps
                              code-action-maps)]
    (util.set-keys mappings)
    (when (client:supports_method :textDocument/completion)
      (vim.lsp.completion.enable true (. client :id) bufnr {:autotrigger true}))))

(fn setup []
  (let [diagnostic-config {:virtual_text {:current_line true :source true}
                           :underline false
                           :float {:border :rounded}
                           :severity_sort true}]
    (vim.diagnostic.config diagnostic-config)
    (vim.api.nvim_create_autocmd :LspAttach {:callback attach-lsp})))

;; (comment local
;;   handlers
;;   {:textDocument/publishDiagnostics (vim.lsp.with vim.lsp.diagnostic.on_publish_diagnostics
;;                                       {:underline [vim.diagnostic.severity.WARN]
;;                                        :update_in_insert true
;;                                        :virtual_text {}
;;                                        :signs false
;;                                        :float {:border :rounded}})
;;    :textDocument/hover (vim.lsp.with vim.lsp.handlers.hover
;;                          {:border :rounded})
;;    :textDocument/signature_help (vim.lsp.with vim.lsp.handlers.signature_help
;;                                   {:border :rounded})})

{: count-diagnostic : setup}
