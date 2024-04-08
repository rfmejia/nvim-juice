-- [nfnl] Compiled from fnl/juice/lsp/init.fnl by https://github.com/Olical/nfnl, do not edit.
local function setup_go()
  local lspconfig = require("lspconfig")
  local settings = {gopls = {analyses = {unusedparams = true}, staticcheck = true}}
  return lspconfig.gopls.setup({settings = settings})
end
local function setup()
  local scalametals = require("juice.lsp.scalametals")
  --[[ "lsp popup colors and borders" ]]
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"})
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = "rounded"})
  vim.diagnostic.config({float = {border = "rounded"}})
  --[[ "set up languages" ]]
  scalametals["register-init-command"]()
  return setup_go()
end
local function set_buffer_opts(client, bufnr)
  local u = require("juice.util")
  u.imap("<C-space>", "<C-x><C-o>", {"noremap", "silent"})
  u.nmap("gd", vim.lsp.buf.definition, {"noremap", "silent", "nowait"})
  u.nmap("gt", vim.lsp.buf.type_definition, {"noremap", "silent", "nowait"})
  u.nmap("gi", vim.lsp.buf.implementation, {"noremap", "silent"})
  u.nmap("gr", vim.lsp.buf.references, {"noremap", "silent"})
  u.nmap("gs", vim.lsp.buf.document_symbol, {"noremap", "silent"})
  u.nmap("gS", vim.lsp.buf.workspace_symbol, {"noremap", "silent"})
  u.nmap("K", vim.lsp.buf.hover, {"noremap", "silent"})
  local function _1_()
    return vim.diagnostic.setqflist({severity = vim.diagnostic.severity.ERROR})
  end
  u.nmap("<localleader>dc", _1_, {"noremap", "silent"})
  u.nmap("<localleader>dC", vim.diagnostic.setqflist, {"noremap", "silent"})
  u.nmap("<localleader>dl", vim.diagnostic.setloclist, {"noremap", "silent"})
  local function _2_()
    return vim.diagnostic.goto_prev({wrap = false})
  end
  u.nmap("[d", _2_, {"noremap", "silent"})
  local function _3_()
    return vim.diagnostic.goto_next({wrap = false})
  end
  u.nmap("]d", _3_, {"noremap", "silent"})
  u.nmap("<localleader>ca", vim.lsp.buf.code_action, {"noremap", "silent"})
  u.nmap("<localleader>cs", vim.lsp.buf.signature_help, {"noremap", "silent"})
  u.nmap("<localleader>cr", vim.lsp.buf.rename, {"noremap"})
  local function _4_()
    return vim.lsp.buf.format({async = true})
  end
  return u.nmap("<localleader>cf", _4_, {"noremap", "silent"})
end
return {["set-buffer-opts"] = set_buffer_opts, setup = setup}
