(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))
(local util (autoload :juice.util))

(lambda set-mappings [bufnr]
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
                    {:desc "goto Workspace symbol" :buffer bufnr}]]
        diagnostic-maps [[:n
                          :K
                          #(vim.lsp.buf.hover {:border :rounded})
                          {:desc "show type" :buffer bufnr}]
                         [:n
                          "[d"
                          #(vim.diagnostic.goto_prev {:wrap false})
                          {:desc "goto next diagnostic" :buffer bufnr}]
                         [:n
                          "]d"
                          #(vim.diagnostic.goto_next {:wrap false})
                          {:desc "goto previous diagnostic" :buffer bufnr}]
                         [:n
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
                           :buffer bufnr}]
                         [:n
                          :gh
                          #(vim.lsp.inlay_hint.enable (not (vim.lsp.inlay_hint.is_enabled)))
                          {:desc "toggle inlay hints" :buffer bufnr}]]
        code-action-maps [[:n
                           :grf
                           #(vim.lsp.buf.format {:async true})
                           {:desc "code format" :buffer bufnr}]]
        mappings (core.concat omnifunc-map goto-maps diagnostic-maps
                              code-action-maps)]
    (util.set-keys mappings)))

(fn configure-diagnostics []
  (vim.diagnostic.config {:underline false
                          :virtual_text {:source :if_many}
                          :signs false
                          :float {:border :rounded}
                          :update_in_insert true
                          :severity_sort true}))

(lambda configure-completion [client bufnr]
  (when (client:supports_method :textDocument/completion)
    (vim.lsp.completion.enable true (. client :id) bufnr {:autotrigger false})))

;; TODO Why not just discover the configs in root/lsp?
(fn setup []
  (let [config {:root_markers [:.git]}
        lsp-configs [:clangd :clojure_lsp :fennel_ls :gopls :jdtls :sqlls]
        on-attach (fn [event]
                    (case (vim.lsp.get_client_by_id event.data.client_id)
                      client (do
                               (set-mappings event.buf)
                               (configure-completion client event.buf)
                               (configure-diagnostics))))]
    (vim.lsp.config "*" config)
    (each [_ lsp-config (ipairs lsp-configs)]
      (vim.lsp.enable lsp-config))
    (vim.api.nvim_create_autocmd :LspAttach {:callback on-attach})))

{: setup}
