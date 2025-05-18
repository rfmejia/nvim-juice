-- [nfnl] fnl/juice/lsp/init.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
local util = autoload("juice.util")
local function count_diagnostic(_3fbufnr, severity)
  _G.assert((nil ~= severity), "Missing argument severity on /home/rfmejia/.config/nvim/fnl/juice/lsp/init.fnl:5")
  return core.count(vim.diagnostic.get(_3fbufnr, {severity = severity}))
end
local function set_mappings(bufnr)
  _G.assert((nil ~= bufnr), "Missing argument bufnr on /home/rfmejia/.config/nvim/fnl/juice/lsp/init.fnl:11")
  local omnifunc_map = {{"i", "<C-space>", "<C-x><C-o>", {buffer = bufnr}}}
  local goto_maps = {{"n", "gd", vim.lsp.buf.definition, {desc = "goto definition", nowait = true, buffer = bufnr}}, {"n", "gt", vim.lsp.buf.type_definition, {desc = "goto type definition", nowait = true, buffer = bufnr}}, {"n", "gW", vim.lsp.buf.workspace_symbol, {desc = "goto Workspace symbol", buffer = bufnr}}}
  local diagnostic_maps
  local function _2_()
    return vim.lsp.buf.hover({border = "rounded"})
  end
  local function _3_()
    return vim.diagnostic.goto_prev({wrap = false})
  end
  local function _4_()
    return vim.diagnostic.goto_next({wrap = false})
  end
  local function _5_()
    return vim.diagnostic.setqflist({severity = vim.diagnostic.severity.ERROR})
  end
  diagnostic_maps = {{"n", "K", _2_, {desc = "show type", buffer = bufnr}}, {"n", "[d", _3_, {desc = "goto next diagnostic", buffer = bufnr}}, {"n", "]d", _4_, {desc = "goto previous diagnostic", buffer = bufnr}}, {"n", "gre", _5_, {desc = "show diagnostic errors of the workspace in quickfix list", buffer = bufnr}}, {"n", "grw", vim.diagnostic.setqflist, {desc = "show diagnostics of the workspace in quickfix list", buffer = bufnr}}, {"n", "grb", vim.diagnostic.setloclist, {desc = "show diagnostics of the buffer in local list", buffer = bufnr}}}
  local code_action_maps
  local function _6_()
    return vim.lsp.buf.format({async = true})
  end
  code_action_maps = {{"n", "grf", _6_, {desc = "code format", buffer = bufnr}}}
  local mappings = core.concat(omnifunc_map, goto_maps, diagnostic_maps, code_action_maps)
  return util["set-keys"](mappings)
end
local function configure_diagnostics()
  return vim.diagnostic.config({virtual_text = {source = "if_many"}, float = {border = "rounded"}, update_in_insert = true, severity_sort = true, signs = false, underline = false})
end
local function configure_completion(client, bufnr)
  _G.assert((nil ~= bufnr), "Missing argument bufnr on /home/rfmejia/.config/nvim/fnl/juice/lsp/init.fnl:68")
  _G.assert((nil ~= client), "Missing argument client on /home/rfmejia/.config/nvim/fnl/juice/lsp/init.fnl:68")
  if client:supports_method("textDocument/completion") then
    return vim.lsp.completion.enable(true, client.id, bufnr, {autotrigger = false})
  else
    return nil
  end
end
local function setup()
  local function _8_(event)
    local _9_ = vim.lsp.get_client_by_id(event.data.client_id)
    if (nil ~= _9_) then
      local client = _9_
      set_mappings(event.buf)
      configure_completion(client, event.buf)
      return configure_diagnostics()
    else
      return nil
    end
  end
  return vim.api.nvim_create_autocmd("LspAttach", {callback = _8_})
end
return {["count-diagnostic"] = count_diagnostic, setup = setup}
