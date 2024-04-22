-- [nfnl] Compiled from fnl/juice/lsp/init.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = autoload("nfnl.core")
local count = _local_2_["count"]
local lspconfig = autoload("lspconfig")
local _local_3_ = autoload("juice.util")
local imap = _local_3_["imap"]
local nmap = _local_3_["nmap"]
local function set_buffer_opts(_, bufnr)
  _G.assert((nil ~= bufnr), "Missing argument bufnr on /home/rfmejia/.config/nvim/fnl/juice/lsp/init.fnl:6")
  imap("<C-space>", "<C-x><C-o>", {"noremap", "silent"})
  nmap("gd", vim.lsp.buf.definition, {"noremap", "silent", "nowait"}, "(g)oto (d)efinition", bufnr)
  nmap("gt", vim.lsp.buf.type_definition, {"noremap", "silent", "nowait"}, "(g)oto (t)ype definition", bufnr)
  nmap("gi", vim.lsp.buf.implementation, {"noremap", "silent"}, "(g)oto (i)mplementation", bufnr)
  nmap("gr", vim.lsp.buf.references, {"noremap", "silent"}, "(g)oto (r)eferences", bufnr)
  nmap("gs", vim.lsp.buf.document_symbol, {"noremap", "silent"}, "(g)oto (s)ymbol", bufnr)
  nmap("gS", vim.lsp.buf.workspace_symbol, {"noremap", "silent"}, "(g)oto workspace (S)ymbol", bufnr)
  nmap("K", vim.lsp.buf.hover, {"noremap", "silent"}, "hover documentation", bufnr)
  local function _4_()
    return vim.diagnostic.setqflist({severity = vim.diagnostic.severity.ERROR})
  end
  nmap("<localleader>de", _4_, {"noremap", "silent"}, "show (d)iagnostic (e)rrors of the workspace in quickfix list", bufnr)
  nmap("<localleader>dw", vim.diagnostic.setqflist, {"noremap", "silent"}, "show (d)iagnostics of the (w)orkspace in quickfix list", bufnr)
  nmap("<localleader>db", vim.diagnostic.setloclist, {"noremap", "silent"}, "show (d)iagnostics of the (b)uffer in local list", bufnr)
  local function _5_()
    return vim.diagnostic.goto_prev({wrap = false})
  end
  nmap("[d", _5_, {"noremap", "silent"}, "goto next diagnostic", bufnr)
  local function _6_()
    return vim.diagnostic.goto_next({wrap = false})
  end
  nmap("]d", _6_, {"noremap", "silent"}, "goto previous diagnostic", bufnr)
  nmap("<localleader>ca", vim.lsp.buf.code_action, {"noremap", "silent"}, "(c)ode (a)ctions", bufnr)
  nmap("<localleader>cs", vim.lsp.buf.signature_help, {"noremap", "silent"}, "(c)ode (s)ignature", bufnr)
  nmap("<localleader>cr", vim.lsp.buf.rename, {"noremap"}, "(c)ode identifier (r)ename", bufnr)
  local function _7_()
    return vim.lsp.buf.format({async = true})
  end
  return nmap("<localleader>cf", _7_, {"noremap", "silent"}, "(c)ode (f)ormat", bufnr)
end
local function setup_go()
  local settings = {gopls = {analyses = {unusedparams = true}, staticcheck = true}}
  return lspconfig.gopls.setup({["set-buffer-opts"] = set_buffer_opts, settings = settings})
end
local function count_diagnostic(_3fbufnr, severity)
  _G.assert((nil ~= severity), "Missing argument severity on /home/rfmejia/.config/nvim/fnl/juice/lsp/init.fnl:48")
  return count(vim.diagnostic.get(_3fbufnr, {severity = severity}))
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
return {["count-diagnostic"] = count_diagnostic, ["set-buffer-opts"] = set_buffer_opts, setup = setup}
