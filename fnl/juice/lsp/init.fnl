(fn setup-go []
  (let [lspconfig (require :lspconfig)
        settings {:gopls {:analyses {:unusedparams true} :staticcheck true}}]
    (lspconfig.gopls.setup {: settings})))

(fn setup []
  (let [scalametals (require :juice.lsp.scalametals)]
    (comment "lsp popup colors and borders")
    (set vim.lsp.handlers.textDocument/hover
         (vim.lsp.with vim.lsp.handlers.hover {:border :rounded}))
    (set vim.lsp.handlers.textDocument/signatureHelp
         (vim.lsp.with vim.lsp.handlers.signature_help {:border :rounded}))
    (vim.diagnostic.config {:float {:border :rounded}})
    (comment "set up languages")
    (scalametals.register-init-command)
    (setup-go)))

(fn set-buffer-opts [client bufnr]
  "Buffer-specific lsp options"
  (let [u (require :juice.util)]
    (u.imap :<C-space> :<C-x><C-o> [:noremap :silent])
    (u.nmap :gd vim.lsp.buf.definition [:noremap :silent :nowait])
    (u.nmap :gt vim.lsp.buf.type_definition [:noremap :silent :nowait])
    (u.nmap :gi vim.lsp.buf.implementation [:noremap :silent])
    (u.nmap :gr vim.lsp.buf.references [:noremap :silent])
    (u.nmap :gs vim.lsp.buf.document_symbol [:noremap :silent])
    (u.nmap :gS vim.lsp.buf.workspace_symbol [:noremap :silent])
    (u.nmap :K vim.lsp.buf.hover [:noremap :silent]) ; diagnostics
    (u.nmap :<localleader>dc
            (fn []
              (vim.diagnostic.setqflist {:severity vim.diagnostic.severity.ERROR}))
            [:noremap :silent])
    (u.nmap :<localleader>dC vim.diagnostic.setqflist [:noremap :silent])
    (u.nmap :<localleader>dl vim.diagnostic.setloclist [:noremap :silent])
    (u.nmap "[d" (fn [] (vim.diagnostic.goto_prev {:wrap false}))
            [:noremap :silent])
    (u.nmap "]d" (fn [] (vim.diagnostic.goto_next {:wrap false}))
            [:noremap :silent]) ; code actions
    (u.nmap :<localleader>ca vim.lsp.buf.code_action [:noremap :silent])
    (u.nmap :<localleader>cs vim.lsp.buf.signature_help [:noremap :silent])
    (u.nmap :<localleader>cr vim.lsp.buf.rename [:noremap])
    (u.nmap :<localleader>cf (fn [] (vim.lsp.buf.format {:async true}))
            [:noremap :silent])))

{: set-buffer-opts : setup}
