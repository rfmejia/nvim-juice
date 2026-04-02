-- [nfnl] fnl/juice/commands.fnl
local commands
local function _1_()
  local _let_2_ = require("nfnl.module")
  local autoload = _let_2_.autoload
  local util = autoload("juice.util")
  util.call("juice.dotenvrc", "load-env")
  return vim.notify("Loaded environment variables")
end
local function _3_()
  return vim.pack.update()
end
commands = {ClipFilename = {"let @+ = getreg('%')", {desc = "copy current file path to clipboard"}}, LoadEnv = {_1_, {desc = "(Re)load environment variables"}}, PackUpdate = {_3_, {desc = "Update remote vim packages"}}}
local function _4_()
  for cmd_name, args in pairs(commands) do
    vim.api.nvim_create_user_command(cmd_name, unpack(args))
  end
  return nil
end
return {setup = _4_}
