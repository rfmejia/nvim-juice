-- [nfnl] Compiled from fnl/juice/lsp/init.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = autoload("nfnl.core")
local count = _local_2_["count"]
local lspconfig = autoload("lspconfig")
local _local_3_ = autoload("juice.util")
local bufmap = _local_3_["bufmap"]
local handlers = {["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {underline = {vim.diagnostic.severity.WARN}, update_in_insert = true, virtual_text = {}, float = {border = "rounded"}, signs = false}), ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"}), ["textDocument/signature_help"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = "rounded"})}
local function set_buffer_opts(_, bufnr)
  _G.assert((nil ~= bufnr), "Missing argument bufnr on /home/rfmejia/.config/nvim/fnl/juice/lsp/init.fnl:6")
  bufmap(bufnr, {i = {["<C-space>"] = {"<C-x><C-o>", {"noremap", "silent"}}}, n = {gd = {vim.lsp.buf.definition, {"noremap", "silent", "nowait"}, "(g)oto (d)efinition"}, gt = {vim.lsp.buf.type_definition, {"noremap", "silent", "nowait"}, "(g)oto (t)ype definition"}, gi = {vim.lsp.buf.implementation, {"noremap", "silent"}, "(g)oto (i)mplementation"}, gr = {vim.lsp.buf.references, {"noremap", "silent"}, "(g)oto (r)eferences"}, gs = {vim.lsp.buf.document_symbol, {"noremap", "silent"}, "(g)oto (s)ymbol"}, gS = {vim.lsp.buf.workspace_symbol, {"noremap", "silent"}, "(g)oto workspace (S)ymbol"}}})
  local function _4_()
    return vim.diagnostic.setqflist({severity = vim.diagnostic.severity.ERROR})
  end
  bufmap(bufnr, {n = {["<localleader>de"] = {_4_, {"noremap", "silent"}, "show (d)iagnostic (e)rrors of the workspace in quickfix list"}, ["<localleader>dw"] = {vim.diagnostic.setqflist, {"noremap", "silent"}, "show (d)iagnostics of the (w)orkspace in quickfix list"}, ["<localleader>db"] = {vim.diagnostic.setloclist, {"noremap", "silent"}, "show (d)iagnostics of the (b)uffer in local list"}}})
  local function _5_()
    return vim.lsp.buf.format({async = true})
  end
  return bufmap(bufnr, {n = {["<localleader>ca"] = {vim.lsp.buf.code_action, {"noremap", "silent"}, "(c)ode (a)ctions"}, ["<localleader>cs"] = {vim.lsp.buf.signature_help, {"noremap", "silent"}, "(c)ode (s)ignature"}, ["<localleader>cr"] = {vim.lsp.buf.rename, {"noremap"}, "(c)ode identifier (r)ename"}, ["<localleader>cf"] = {_5_, {"noremap", "silent"}, "(c)ode (f)ormat"}}})
end
local function setup_go()
  local settings = {gopls = {analyses = {unusedparams = true}, staticcheck = true}}
  return lspconfig.gopls.setup({["set-buffer-opts"] = set_buffer_opts, settings = settings})
end
local function count_diagnostic(_3fbufnr, severity)
  _G.assert((nil ~= severity), "Missing argument severity on /home/rfmejia/.config/nvim/fnl/juice/lsp/init.fnl:55")
  return count(vim.diagnostic.get(_3fbufnr, {severity = severity}))
end
local function setup()
  local scalametals = autoload("juice.lsp.scalametals")
  scalametals["register-init-command"]()
  lspconfig.clojure_lsp.setup({on_attach = set_buffer_opts, handlers = handlers})
  local settings = {gopls = {analyses = {unusedparams = true}, staticcheck = true}}
  return lspconfig.gopls.setup({on_attach = set_buffer_opts, settings = settings, handlers = handlers})
end
return {["count-diagnostic"] = count_diagnostic, handlers = handlers, ["set-buffer-opts"] = set_buffer_opts, setup = setup}
