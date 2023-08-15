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

(defn setup []
  ; setup default lsp key mappings
  (nmap "<f6>" (lua-cmd "vim.diagnostic.setqflist({severity = vim.diagnostic.severity.ERROR})") [noremap silent])
  (nmap "<f7>" (lua-cmd "vim.diagnostic.setloclist()") [noremap silent])
  (nmap "[d" (lua-cmd "vim.diagnostic.goto_prev({wrap = false})") [noremap silent])
  (nmap "]d" (lua-cmd "vim.diagnostic.goto_next({wrap = false})") [noremap silent])
  (imap "<C-space>" "<C-x><C-o>" [noremap silent])

  ; lsp virtual text, error and warning styling
  (vim.cmd "hi Conceal cterm=italic ctermbg=none ctermfg=59 gui=italic guibg=none guifg=59")

  ; lsp popup colors and borders
  (vim.cmd "hi NormalFloat ctermbg=black guibg=black")
  (vim.cmd "hi WinSeparator ctermbg=black ctermfg=69 guibg=black guifg=69")
  (set vim.lsp.handlers.textDocument/hover (vim.lsp.with vim.lsp.handlers.hover {:border "rounded"}))
  (set vim.lsp.handlers.textDocument/signatureHelp (vim.lsp.with vim.lsp.handlers.signature_help {:border "rounded"}))
  (vim.diagnostic.config {:float {:border "rounded"}})

  (scalametals.register-init-command))

(defn set-buffer-opts [client bufnr]
  "Buffer-specific lsp options"

  ; Enable completion triggered by <c-x><c-o>
  (tset vim.bo bufnr :omnifunc "v:lua.vim.lsp.omnifunc")

  (nmap "gd" (lua-cmd "vim.lsp.buf.definition()") [noremap silent nowait])
  (nmap "gt" (lua-cmd "vim.lsp.buf.type_definition()") [noremap silent nowait])
  (nmap "gi" (lua-cmd "vim.lsp.buf.implementation()") [noremap silent])
  (nmap "gr" (lua-cmd "vim.lsp.buf.references()") [noremap silent])
  (nmap "gs" (lua-cmd "vim.lsp.buf.document_symbol()") [noremap silent])
  (nmap "gS" (lua-cmd "vim.lsp.buf.workspace_symbol()") [noremap silent])
  (nmap "K" (lua-cmd "vim.lsp.buf.hover()") [noremap silent])
  (nmap "<localleader>ca" (lua-cmd "vim.lsp.buf.code_action()") [noremap silent])
  (nmap "<localleader>cr" (lua-cmd "vim.lsp.buf.rename()") [noremap silent])
  (nmap "<localleader>cf" (lua-cmd "vim.lsp.buf.format({async = true})") [noremap silent]))
