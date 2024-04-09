(local {: autoload} (require :nfnl.module))

(fn setup-go []
  (let [lspconfig (autoload :lspconfig)
        settings {:gopls {:analyses {:unusedparams true} :staticcheck true}}]
    (lspconfig.gopls.setup {: settings})))

(fn set-buffer-opts [client bufnr]
  "Buffer-specific lsp options"
  (local {: nmap : imap} (autoload :juice.util))
  (imap :<C-space> :<C-x><C-o> [:noremap :silent])
  (nmap :gd vim.lsp.buf.definition [:noremap :silent :nowait])
  (nmap :gt vim.lsp.buf.type_definition [:noremap :silent :nowait])
  (nmap :gi vim.lsp.buf.implementation [:noremap :silent])
  (nmap :gr vim.lsp.buf.references [:noremap :silent])
  (nmap :gs vim.lsp.buf.document_symbol [:noremap :silent])
  (nmap :gS vim.lsp.buf.workspace_symbol [:noremap :silent])
  (nmap :K vim.lsp.buf.hover [:noremap :silent]) ; diagnostics
  (nmap :<localleader>dc
        (fn []
          (vim.diagnostic.setqflist {:severity vim.diagnostic.severity.ERROR}))
        [:noremap :silent])
  (nmap :<localleader>dC vim.diagnostic.setqflist [:noremap :silent])
  (nmap :<localleader>dl vim.diagnostic.setloclist [:noremap :silent])
  (nmap "[d" (fn [] (vim.diagnostic.goto_prev {:wrap false}))
        [:noremap :silent])
  (nmap "]d" (fn [] (vim.diagnostic.goto_next {:wrap false}))
        [:noremap :silent]) ; code actions
  (nmap :<localleader>ca vim.lsp.buf.code_action [:noremap :silent])
  (nmap :<localleader>cs vim.lsp.buf.signature_help [:noremap :silent])
  (nmap :<localleader>cr vim.lsp.buf.rename [:noremap])
  (nmap :<localleader>cf (fn [] (vim.lsp.buf.format {:async true}))
        [:noremap :silent]))

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

{: set-buffer-opts : setup}
