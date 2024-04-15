-- [nfnl] Compiled from fnl/juice/lsp/init.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local function setup_go()
  local lspconfig = autoload("lspconfig")
  local settings = {gopls = {analyses = {unusedparams = true}, staticcheck = true}}
  return lspconfig.gopls.setup({settings = settings})
end
local function set_buffer_opts(client, bufnr)
  _G.assert((nil ~= bufnr), "Missing argument bufnr on /home/rfmejia/.config/nvim/fnl/juice/lsp/init.fnl:8")
  _G.assert((nil ~= client), "Missing argument client on /home/rfmejia/.config/nvim/fnl/juice/lsp/init.fnl:8")
  local _local_2_ = autoload("juice.util")
  local nmap = _local_2_["nmap"]
  local imap = _local_2_["imap"]
  imap("<C-space>", "<C-x><C-o>", {"noremap", "silent"})
  nmap("gd", vim.lsp.buf.definition, {"noremap", "silent", "nowait", "buffer"})
  nmap("gt", vim.lsp.buf.type_definition, {"noremap", "silent", "nowait", "buffer"})
  nmap("gi", vim.lsp.buf.implementation, {"noremap", "silent", "buffer"})
  nmap("gr", vim.lsp.buf.references, {"noremap", "silent", "buffer"})
  nmap("gs", vim.lsp.buf.document_symbol, {"noremap", "silent", "buffer"})
  nmap("gS", vim.lsp.buf.workspace_symbol, {"noremap", "silent", "buffer"})
  nmap("K", vim.lsp.buf.hover, {"noremap", "silent", "buffer"})
  local function _3_()
    return vim.diagnostic.setqflist({severity = vim.diagnostic.severity.ERROR})
  end
  nmap("<localleader>dc", _3_, {"noremap", "silent", "buffer"})
  nmap("<localleader>dC", vim.diagnostic.setqflist, {"noremap", "silent", "buffer"})
  nmap("<localleader>dl", vim.diagnostic.setloclist, {"noremap", "silent", "buffer"})
  local function _4_()
    return vim.diagnostic.goto_prev({wrap = false})
  end
  nmap("[d", _4_, {"noremap", "silent", "buffer"})
  local function _5_()
    return vim.diagnostic.goto_next({wrap = false})
  end
  nmap("]d", _5_, {"noremap", "silent", "buffer"})
  nmap("<localleader>ca", vim.lsp.buf.code_action, {"noremap", "silent", "buffer"})
  nmap("<localleader>cs", vim.lsp.buf.signature_help, {"noremap", "silent", "buffer"})
  nmap("<localleader>cr", vim.lsp.buf.rename, {"noremap", "buffer"})
  local function _6_()
    return vim.lsp.buf.format({async = true})
  end
  return nmap("<localleader>cf", _6_, {"noremap", "silent", "buffer"})
end
local function setup()
  local scalametals = autoload("juice.lsp.scalametals")
  --[[ "lsp popup colors and borders" ]]
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"})
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = "rounded"})
  vim.diagnostic.config({float = {border = "rounded"}})
  --[[ "set up languages" ]]
  scalametals["register-init-command"]()
  return setup_go()
end
return {["set-buffer-opts"] = set_buffer_opts, setup = setup}
