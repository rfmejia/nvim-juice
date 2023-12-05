(module lsp
  {autoload {a aniseed.core
             s aniseed.string
             u util
             scalametals juice.lsp.scalametals}})

(local nmap u.nmap)
(local imap u.imap)
(local noremap u.noremap)
(local silent u.silent)
(local nowait u.nowait)
(local lua-cmd u.lua-cmd)

(defn setup-go []
  (let [lspconfig (require :lspconfig)
        settings {:gopls {:analyses {:unusedparams true}
                          :staticcheck true}}]
    (lspconfig.gopls.setup {: settings })))

(defn setup []
  ; setup default lsp key mappings
  (nmap "<localleader>dd" vim.diagnostic.setqflist [noremap silent])
  (nmap "<localleader>de" (fn [] (vim.diagnostic.setqflist {:severity vim.diagnostic.severity.ERROR})) [noremap silent])
  (nmap "<localleader>dl" vim.diagnostic.setloclist [noremap silent])
  (nmap "[d" (fn [] (vim.diagnostic.goto_prev {:wrap false})) [noremap silent])
  (nmap "]d" (fn [] (vim.diagnostic.goto_next {:wrap false})) [noremap silent])
  (imap "<C-space>" "<C-x><C-o>" [noremap silent])

  ; lsp virtual text, error and warning styling
  (vim.cmd "hi Conceal cterm=italic ctermbg=none ctermfg=59 gui=italic guibg=none guifg=59")

  ; lsp popup colors and borders
  (vim.cmd "hi WinSeparator ctermbg=black ctermfg=69 guibg=black guifg=69")
  (set vim.lsp.handlers.textDocument/hover (vim.lsp.with vim.lsp.handlers.hover {:border "rounded"}))
  (set vim.lsp.handlers.textDocument/signatureHelp (vim.lsp.with vim.lsp.handlers.signature_help {:border "rounded"}))
  (vim.diagnostic.config {:float {:border "rounded"}})

  (scalametals.register-init-command)
  (setup-go))

(defn set-buffer-opts [client bufnr]
  "Buffer-specific lsp options"

  (nmap "gd" vim.lsp.buf.definition [noremap silent nowait])
  (nmap "gt" vim.lsp.buf.type_definition [noremap silent nowait])
  (nmap "gi" vim.lsp.buf.implementation [noremap silent])
  (nmap "gr" vim.lsp.buf.references [noremap silent])
  (nmap "gs" vim.lsp.buf.document_symbol [noremap silent])
  (nmap "gS" vim.lsp.buf.workspace_symbol [noremap silent])
  (nmap "K" vim.lsp.buf.hover [noremap silent])
  (nmap "<localleader>ca" vim.lsp.buf.code_action [noremap silent])
  (nmap "<localleader>cs" vim.lsp.buf.signature_help [noremap silent])
  (nmap "<localleader>cr" vim.lsp.buf.rename [noremap])
  (nmap "<localleader>cf" (fn [] (vim.lsp.buf.format {:async true})) [noremap silent]))
