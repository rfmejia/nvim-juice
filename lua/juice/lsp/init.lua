-- [nfnl] Compiled from fnl/juice/lsp/init.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = autoload("nfnl.core")
local count = _local_2_["count"]
local lspconfig = autoload("lspconfig")
local _local_3_ = autoload("juice.util")
local bufmap = _local_3_["bufmap"]
local function set_buffer_opts(_, bufnr)
  _G.assert((nil ~= bufnr), "Missing argument bufnr on /home/rfmejia/.config/nvim/fnl/juice/lsp/init.fnl:6")
  bufmap(bufnr, {i = {["<C-space>"] = {"<C-x><C-o>", {"noremap", "silent"}}}, n = {gd = {vim.lsp.buf.definition, {"noremap", "silent", "nowait"}, "(g)oto (d)efinition"}, gt = {vim.lsp.buf.type_definition, {"noremap", "silent", "nowait"}, "(g)oto (t)ype definition"}, gi = {vim.lsp.buf.implementation, {"noremap", "silent"}, "(g)oto (i)mplementation"}, gr = {vim.lsp.buf.references, {"noremap", "silent"}, "(g)oto (r)eferences"}, gs = {vim.lsp.buf.document_symbol, {"noremap", "silent"}, "(g)oto (s)ymbol"}, gS = {vim.lsp.buf.workspace_symbol, {"noremap", "silent"}, "(g)oto workspace (S)ymbol"}, K = {vim.lsp.buf.hover, {"noremap", "silent"}, "hover documentation"}}})
  local function _4_()
    return vim.diagnostic.setqflist({severity = vim.diagnostic.severity.ERROR})
  end
  local function _5_()
    return vim.diagnostic.goto_prev({wrap = false})
  end
  local function _6_()
    return vim.diagnostic.goto_next({wrap = false})
  end
  bufmap(bufnr, {n = {["<localleader>de"] = {_4_, {"noremap", "silent"}, "show (d)iagnostic (e)rrors of the workspace in quickfix list"}, ["<localleader>dw"] = {vim.diagnostic.setqflist, {"noremap", "silent"}, "show (d)iagnostics of the (w)orkspace in quickfix list"}, ["<localleader>db"] = {vim.diagnostic.setloclist, {"noremap", "silent"}, "show (d)iagnostics of the (b)uffer in local list"}, ["[d"] = {_5_, {"noremap", "silent"}, "goto next diagnostic"}, ["]d"] = {_6_, {"noremap", "silent"}, "goto previous diagnostic"}}})
  local function _7_()
    return vim.lsp.buf.format({async = true})
  end
  return bufmap(bufnr, {n = {["<localleader>ca"] = {vim.lsp.buf.code_action, {"noremap", "silent"}, "(c)ode (a)ctions"}, ["<localleader>cs"] = {vim.lsp.buf.signature_help, {"noremap", "silent"}, "(c)ode (s)ignature"}, ["<localleader>cr"] = {vim.lsp.buf.rename, {"noremap"}, "(c)ode identifier (r)ename"}, ["<localleader>cf"] = {_7_, {"noremap", "silent"}, "(c)ode (f)ormat"}}})
end
local function setup_go()
  local settings = {gopls = {analyses = {unusedparams = true}, staticcheck = true}}
  return lspconfig.gopls.setup({["set-buffer-opts"] = set_buffer_opts, settings = settings})
end
local function count_diagnostic(_3fbufnr, severity)
  _G.assert((nil ~= severity), "Missing argument severity on /home/rfmejia/.config/nvim/fnl/juice/lsp/init.fnl:65")
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
