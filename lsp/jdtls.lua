-- [nfnl] fnl/lsp/jdtls.fnl
local handlers = require("vim.lsp.handlers")
local env = {HOME = vim.uv.os_homedir(), JDTLS_JVM_ARGS = os.getenv("JDTLS_JVM_ARGS"), XDG_CACHE_HOME = os.getenv("XDG_CACHE_HOME")}
local function get_cache_dir()
  return ((env.XDG_CACHE_HOME and env.XDG_CACHE_HOME) or (env.HOME .. "/.cache"))
end
local function get_jdtls_cache_dir()
  return (get_cache_dir() .. "/jdtls")
end
local function get_jdtls_config_dir()
  return (get_jdtls_cache_dir() .. "/config")
end
local function get_jdtls_workspace_dir()
  return (get_jdtls_cache_dir() .. "/workspace")
end
local function get_jdtls_jvm_args()
  local args = {}
  for a in string.gmatch((env.JDTLS_JVM_ARGS or ""), "%S+") do
    local arg = string.format("--jvm-arg=%s", a)
    table.insert(args, arg)
  end
  return unpack(args)
end
local function fix_zero_version(workspace_edit)
  if (workspace_edit and workspace_edit.documentChanges) then
    for _, change in pairs(workspace_edit.documentChanges) do
      local text_document = change.textDocument
      if (text_document and text_document.version and (text_document.version == 0)) then
        text_document.version = nil
      else
      end
    end
  else
  end
  return workspace_edit
end
local function on_textdocument_codeaction(err, actions, ctx)
  for _, action in ipairs(actions) do
    if (action.command == "java.apply.workspaceEdit") then
      action.edit = fix_zero_version((action.edit or action.arguments[1]))
    elseif ((type(action.command) == "table") and (action.command.command == "java.apply.workspaceEdit")) then
      action.edit = fix_zero_version((action.edit or action.command.arguments[1]))
    else
    end
  end
  return handlers[ctx.method](err, actions, ctx)
end
local function on_textdocument_rename(err, workspace_edit, ctx)
  return handlers[ctx.method](err, fix_zero_version(workspace_edit), ctx)
end
local function on_workspace_applyedit(err, workspace_edit, ctx)
  return handlers[ctx.method](err, fix_zero_version(workspace_edit), ctx)
end
local function on_language_status(_, result)
  local command = vim.api.nvim_command
  command("echohl ModeMsg")
  command(string.format("echo \"%s\"", result.message))
  return command("echohl None")
end
return {cmd = {"jdtls", "-configuration", get_jdtls_config_dir(), "-data", get_jdtls_workspace_dir(), get_jdtls_jvm_args()}, filetypes = {"java"}, handlers = {["language/status"] = vim.schedule_wrap(on_language_status), ["textDocument/codeAction"] = on_textdocument_codeaction, ["textDocument/rename"] = on_textdocument_rename, ["workspace/applyEdit"] = on_workspace_applyedit}, init_options = {jvm_args = {}, os_config = nil, workspace = get_jdtls_workspace_dir()}, single_file_support = true}
