-- [nfnl] fnl/lsp/clangd.fnl
local function switch_source_header(bufnr, client)
  local method_name = "textDocument/switchSourceHeader"
  if (not client or not client:supports_method(method_name)) then
    return vim.notify(("method %s is not supported by any servers active on the current buffer"):format(method_name))
  else
    local params = vim.lsp.util.make_text_document_params(bufnr)
    local function _1_(err, result)
      if err then
        error(tostring(err))
      else
      end
      if not result then
        return vim.notify("corresponding file cannot be determined")
      else
        return vim.cmd.edit(vim.uri_to_fname(result))
      end
    end
    return client:request(method_name, params, _1_, bufnr)
  end
end
local function symbol_info(bufnr, client)
  local method_name = "textDocument/symbolInfo"
  if (not client or not client:supports_method(method_name)) then
    return vim.notify("Clangd client not found", vim.log.levels.ERROR)
  else
    local win = vim.api.nvim_get_current_win()
    local params = vim.lsp.util.make_position_params(win, client.offset_encoding)
    local function _5_(err, res)
      if (err or (#res == 0)) then
        --[[ "Clangd always returns an error, there is no reason to parse it" ]]
        return nil
      else
        local container = string.format("container: %s", res[1].containerName)
        local name = string.format("name: %s", res[1].name)
        return vim.lsp.util.open_floating_preview({name, container}, "", {height = 2, width = math.max(string.len(name), string.len(container)), title = "Symbol Info", focus = false, focusable = false})
      end
    end
    return client:request(method_name, params, _5_, bufnr)
  end
end
local function _8_(client, init_result)
  if init_result.offsetEncoding then
    client.offset_encoding = init_result.offsetEncoding
    return nil
  else
    return nil
  end
end
local function _10_(client, bufnr)
  local function _11_()
    return switch_source_header(bufnr, client)
  end
  vim.api.nvim_buf_create_user_command(bufnr, "LspClangdSwitchSourceHeader", _11_, {desc = "Switch between source/header"})
  local function _12_()
    return symbol_info(bufnr, client)
  end
  return vim.api.nvim_buf_create_user_command(bufnr, "LspClangdShowSymbolInfo", _12_, {desc = "Show symbol info"})
end
return {cmd = {"clangd"}, filetypes = {"c", "cpp", "objc", "objcpp", "cuda"}, root_markers = {".clangd", ".clang-tidy", ".clang-format", "compile_commands.json", "compile_flags.txt", "configure.ac", ".git"}, capabilities = {textDocument = {completion = {editsNearCursor = true}}, offsetEncoding = {"utf-8", "utf-16"}}, on_init = _8_, on_attach = _10_}
