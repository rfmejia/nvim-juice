-- [nfnl] fnl/juice/lsp.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local core = autoload("nfnl.core")
local util = autoload("juice.util")
local function set_mappings(bufnr)
  if (nil == bufnr) then
    _G.error("Missing argument bufnr on fnl/juice/lsp.fnl:5", 2)
  else
  end
  local goto_maps = {{"n", "gd", vim.lsp.buf.definition, {desc = "goto definition", nowait = true, buffer = bufnr}}, {"n", "gW", vim.lsp.buf.workspace_symbol, {desc = "goto Workspace symbol", buffer = bufnr}}}
  local diagnostic_maps
  local function _3_()
    return vim.diagnostic.jump({count = -1, wrap = false})
  end
  local function _4_()
    return vim.diagnostic.jump({count = 1, wrap = false})
  end
  local function _5_()
    return vim.diagnostic.setqflist({severity = vim.diagnostic.severity.ERROR})
  end
  local function _6_()
    return vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end
  diagnostic_maps = {{"n", "[d", _3_, {desc = "jump to previous diagnostic", buffer = bufnr}}, {"n", "]d", _4_, {desc = "jump to next diagnostic", buffer = bufnr}}, {"n", "gre", _5_, {desc = "show diagnostic errors of the workspace in quickfix list", buffer = bufnr}}, {"n", "grw", vim.diagnostic.setqflist, {desc = "show diagnostics of the workspace in quickfix list", buffer = bufnr}}, {"n", "grb", vim.diagnostic.setloclist, {desc = "show diagnostics of the buffer in local list", buffer = bufnr}}, {"n", "grh", _6_, {desc = "toggle inlay hints", buffer = bufnr}}}
  local code_action_maps
  local function _7_()
    return vim.lsp.buf.format({async = true})
  end
  code_action_maps = {{"n", "grf", _7_, {desc = "code format", buffer = bufnr}}}
  local mappings = core.concat(goto_maps, diagnostic_maps, code_action_maps)
  return util["set-keys"](mappings)
end
local function configure_diagnostics()
  return vim.diagnostic.config({virtual_text = true, float = {border = "rounded"}, update_in_insert = true, severity_sort = true, signs = false, underline = false})
end
local function configure_completion(client, bufnr)
  if (nil == bufnr) then
    _G.error("Missing argument bufnr on fnl/juice/lsp.fnl:56", 2)
  else
  end
  if (nil == client) then
    _G.error("Missing argument client on fnl/juice/lsp.fnl:56", 2)
  else
  end
  if client:supports_method("textDocument/completion") then
    return vim.lsp.completion.enable(true, client.id, bufnr, {autotrigger = true})
  else
    return nil
  end
end
local function setup()
  local lsp_configs = {"clangd", "clojure_lsp", "fennel_ls", "gopls", "jdtls"}
  local on_attach
  local function _11_(event)
    local case_12_ = vim.lsp.get_client_by_id(event.data.client_id)
    if (nil ~= case_12_) then
      local client = case_12_
      set_mappings(event.buf)
      configure_completion(client, event.buf)
      return configure_diagnostics()
    else
      return nil
    end
  end
  on_attach = _11_
  vim.lsp.enable(lsp_configs)
  return vim.api.nvim_create_autocmd("LspAttach", {callback = on_attach})
end
return {setup = setup}
