-- [nfnl] Compiled from fnl/juice/lsp/init.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
local util = autoload("juice.util")
local function count_diagnostic(_3fbufnr, severity)
  _G.assert((nil ~= severity), "Missing argument severity on /home/rfmejia/.config/nvim/fnl/juice/lsp/init.fnl:5")
  return core.count(vim.diagnostic.get(_3fbufnr, {severity = severity}))
end
local function attach_lsp(args)
  _G.assert((nil ~= args), "Missing argument args on /home/rfmejia/.config/nvim/fnl/juice/lsp/init.fnl:11")
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  local bufnr = args.buf
  local omnifunc_map = {{"i", "<C-space>", "<C-x><C-o>", {buffer = bufnr}}}
  local goto_maps = {{"n", "gd", vim.lsp.buf.definition, {desc = "goto definition", nowait = true, buffer = bufnr}}, {"n", "gt", vim.lsp.buf.type_definition, {desc = "goto type definition", nowait = true, buffer = bufnr}}, {"n", "gW", vim.lsp.buf.workspace_symbol, {desc = "goto Workspace symbol", buffer = bufnr}}}
  local diagnostic_maps
  local function _2_()
    return vim.diagnostic.setqflist({severity = vim.diagnostic.severity.ERROR})
  end
  diagnostic_maps = {{"n", "gre", _2_, {desc = "show diagnostic errors of the workspace in quickfix list", buffer = bufnr}}, {"n", "grw", vim.diagnostic.setqflist, {desc = "show diagnostics of the workspace in quickfix list", buffer = bufnr}}, {"n", "grb", vim.diagnostic.setloclist, {desc = "show diagnostics of the buffer in local list", buffer = bufnr}}}
  local code_action_maps
  local function _3_()
    return vim.lsp.buf.format({async = true})
  end
  code_action_maps = {{"n", "grf", _3_, {desc = "code format", buffer = bufnr}}}
  local mappings = core.concat(omnifunc_map, goto_maps, diagnostic_maps, code_action_maps)
  util["set-keys"](mappings)
  if client:supports_method("textDocument/completion") then
    return vim.lsp.completion.enable(true, client.id, bufnr, {autotrigger = true})
  else
    return nil
  end
end
local function setup()
  local diagnostic_config = {virtual_text = {current_line = true, source = true}, float = {border = "rounded"}, severity_sort = true, underline = false}
  vim.diagnostic.config(diagnostic_config)
  return vim.api.nvim_create_autocmd("LspAttach", {callback = attach_lsp})
end
return {["count-diagnostic"] = count_diagnostic, setup = setup}
