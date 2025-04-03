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
  local goto_maps = {{"n", "gd", vim.lsp.buf.definition, {desc = "goto definition", nowait = true, buffer = bufnr}}, {"n", "gt", vim.lsp.buf.type_definition, {desc = "goto type definition", nowait = true, buffer = bufnr}}, {"n", "gW", vim.lsp.buf.workspace_symbol, {desc = "(g)oto (W)orkspace symbol", buffer = bufnr}}}
  local diagnostic_maps
  local function _2_()
    return vim.diagnostic.setqflist({severity = vim.diagnostic.severity.ERROR})
  end
  diagnostic_maps = {{"n", "<localleader>de", _2_, {desc = "show (d)iagnostic (e)rrors of the workspace in quickfix list", buffer = bufnr}}, {"n", "<localleader>dw", vim.diagnostic.setqflist, {desc = "show (d)iagnostics of the (w)orkspace in quickfix list", buffer = bufnr}}, {"n", "<localleader>db", vim.diagnostic.setloclist, {desc = "show (d)iagnostics of the (b)uffer in local list", buffer = bufnr}}}
  local code_action_maps
  local function _3_()
    return vim.lsp.buf.format({async = true})
  end
  code_action_maps = {{"n", "<localleader>cf", _3_, {desc = "code format", buffer = bufnr}}}
  local mappings = core.concat(omnifunc_map, goto_maps, diagnostic_maps, code_action_maps)
  return util["set-keys"](mappings)
end
local function count_diagnostic(_3fbufnr, severity)
  _G.assert((nil ~= severity), "Missing argument severity on /home/rfmejia/.config/nvim/fnl/juice/lsp/init.fnl:57")
  return core.count(vim.diagnostic.get(_3fbufnr, {severity = severity}))
end
local function setup_autocomplete(ev)
  local client = vim.lsp.get_client_by_id(ev.data.client_id)
  if client:supports_method("textDocument/completion") then
    return vim.lsp.completion.enable(true, client.id, ev.buf, {autotrigger = true})
  else
    return nil
  end
end
local function setup()
  local scalametals = autoload("juice.lsp.scalametals")
  local diagnostic_config = {virtual_text = {current_line = true, source = true}, severity_sort = true}
  local go_settings = {gopls = {analyses = {unusedparams = true}, staticcheck = true}}
  vim.diagnostic.config(diagnostic_config)
  vim.api.nvim_create_autocmd("LspAttach", {callback = setup_autocomplete})
  scalametals["register-init-command"]()
  lspconfig.ts_ls.setup({on_attach = set_buffer_opts, handlers = handlers})
  lspconfig.jdtls.setup({on_attach = set_buffer_opts, handlers = handlers})
  lspconfig.clojure_lsp.setup({on_attach = set_buffer_opts, handlers = handlers})
  return lspconfig.gopls.setup({on_attach = set_buffer_opts, ["go-settings"] = go_settings, handlers = handlers})
end
return {["count-diagnostic"] = count_diagnostic, handlers = handlers, ["set-buffer-opts"] = set_buffer_opts, setup = setup}
