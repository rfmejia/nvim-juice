(local {: autoload} (require :nfnl.module))
(local {: count} (autoload :nfnl.core))
(local lspconfig (autoload :lspconfig))
(local {: bufmap} (autoload :juice.util))

(lambda set-buffer-opts [_ bufnr]
  "Buffer-specific lsp options"
  (bufmap bufnr {:i {:<C-space> [:<C-x><C-o> [:noremap :silent]]}
                 :n {:gd [vim.lsp.buf.definition
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
                          "(g)oto workspace (S)ymbol"]
                     :K [vim.lsp.buf.hover
                         [:noremap :silent]
                         "hover documentation"]}})
  (bufmap bufnr ; diagnostics
          {:n {:<localleader>de [#(vim.diagnostic.setqflist {:severity vim.diagnostic.severity.ERROR})
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
                     "goto previous diagnostic"]}})
  (bufmap bufnr ; code actions
          {:n {:<localleader>ca [vim.lsp.buf.code_action
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
                                 "(c)ode (f)ormat"]}}))

(fn setup-go []
  (let [settings {:gopls {:analyses {:unusedparams true} :staticcheck true}}]
    (lspconfig.gopls.setup {: set-buffer-opts : settings})))

(lambda count-diagnostic [?bufnr severity]
  "Returns 'n! ' where n is the number of diagnostic messages, otherwise an empty string"
  (-> ?bufnr
      (vim.diagnostic.get {: severity})
      (count)))

(fn setup []
  (let [scalametals (autoload :juice.lsp.scalametals)]
    (comment "lsp popup colors and borders")
    (set vim.lsp.handlers.textDocument/hover
         (vim.lsp.with vim.lsp.handlers.hover {:border :rounded}))
    (set vim.lsp.handlers.textDocument/signatureHelp
         (vim.lsp.with vim.lsp.handlers.signature_help {:border :rounded}))
    (vim.diagnostic.config {:float {:border :rounded}})
    (comment "set up languages")
    (scalametals.register-init-command)
    (setup-go)))

{: count-diagnostic : set-buffer-opts : setup}
