-- [nfnl] Compiled from fnl/juice/lsp/init.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
local lspconfig = autoload("lspconfig")
local util = autoload("juice.util")
local handlers = {["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {underline = {vim.diagnostic.severity.WARN}, update_in_insert = true, virtual_text = {}, float = {border = "rounded"}, signs = false}), ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"}), ["textDocument/signature_help"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = "rounded"})}
local function set_buffer_opts(_, bufnr)
  _G.assert((nil ~= bufnr), "Missing argument bufnr on /home/rfmejia/.config/nvim/fnl/juice/lsp/init.fnl:18")
  vim.opt.omnifunc = "v:lua.vim.lsp.omnifunc"
  local omnifunc_map = {{"i", "<C-space>", "<C-x><C-o>", {buffer = bufnr}}}
  local goto_maps = {{"n", "gd", vim.lsp.buf.definition, {desc = "(g)oto (d)efinition", nowait = true, buffer = bufnr}}, {"n", "gt", vim.lsp.buf.type_definition, {desc = "(g)oto (t)ype definition", nowait = true, buffer = bufnr}}, {"n", "gi", vim.lsp.buf.implementation, {desc = "(g)oto (i)mplementation", buffer = bufnr}}, {"n", "gr", vim.lsp.buf.references, {desc = "(g)oto (r)eferences", buffer = bufnr}}, {"n", "gs", vim.lsp.buf.document_symbol, {desc = "(g)oto (s)ymbol", buffer = bufnr}}, {"n", "gS", vim.lsp.buf.workspace_symbol, {desc = "(g)oto workspace (S)ymbol", buffer = bufnr}}}
  local diagnostic_maps
  local function _2_()
    return vim.diagnostic.setqflist({severity = vim.diagnostic.severity.ERROR})
  end
  local function _3_()
    return vim.diagnostic.goto_prev({wrap = false})
  end
  local function _4_()
    return vim.diagnostic.goto_next({wrap = false})
  end
  diagnostic_maps = {{"n", "<localleader>de", _2_, {desc = "show (d)iagnostic (e)rrors of the workspace in quickfix list", buffer = bufnr}}, {"n", "<localleader>dw", vim.diagnostic.setqflist, {desc = "show (d)iagnostics of the (w)orkspace in quickfix list", buffer = bufnr}}, {"n", "<localleader>db", vim.diagnostic.setloclist, {desc = "show (d)iagnostics of the (b)uffer in local list", buffer = bufnr}}, {"n", "[d", _3_, {desc = "goto next diagnostic", buffer = bufnr}}, {"n", "]d", _4_, {desc = "goto previous diagnostic", buffer = bufnr}}}
  local code_action_maps
  local function _5_()
    return vim.lsp.buf.format({async = true})
  end
  code_action_maps = {{"n", "<localleader>ca", vim.lsp.buf.code_action, {desc = "(c)ode (a)ctions", buffer = bufnr}}, {"n", "<localleader>cs", vim.lsp.buf.signature_help, {desc = "(c)ode (s)ignature", buffer = bufnr}}, {"n", "<localleader>cr", vim.lsp.buf.rename, {desc = "(c)ode identifier (r)ename", buffer = bufnr}}, {"n", "<localleader>cf", _5_, {desc = "(c)ode (f)ormat", buffer = bufnr}}}
  local mappings = core.concat(omnifunc_map, goto_maps, diagnostic_maps, code_action_maps)
  return util["set-keys"](mappings)
end
local function count_diagnostic(_3fbufnr, severity)
  _G.assert((nil ~= severity), "Missing argument severity on /home/rfmejia/.config/nvim/fnl/juice/lsp/init.fnl:91")
  return core.count(vim.diagnostic.get(_3fbufnr, {severity = severity}))
end
local function setup()
  local scalametals = autoload("juice.lsp.scalametals")
  local go_settings = {gopls = {analyses = {unusedparams = true}, staticcheck = true}}
  scalametals["register-init-command"]()
  lspconfig.clojure_lsp.setup({on_attach = set_buffer_opts, handlers = handlers})
  return lspconfig.gopls.setup({on_attach = set_buffer_opts, ["go-settings"] = go_settings, handlers = handlers})
end
return {["count-diagnostic"] = count_diagnostic, handlers = handlers, ["set-buffer-opts"] = set_buffer_opts, setup = setup}
