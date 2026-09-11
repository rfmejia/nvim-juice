-- [nfnl] fnl/juice/commands.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local util = autoload("juice.util")
local commands
local function _2_()
  util.call("juice.dotenvrc", "load-env")
  return vim.notify("Loaded environment variables")
end
local function _3_()
  return vim.pack.update()
end
commands = {ClipFilename = {"let @+ = getreg('%')", {desc = "copy current file path to clipboard"}}, LoadEnv = {_2_, {desc = "(Re)load environment variables"}}, PackUpdate = {_3_, {desc = "Update remote vim packages"}}}
local function _4_()
  for cmd_name, args in pairs(commands) do
    vim.api.nvim_create_user_command(cmd_name, unpack(args))
  end
  return nil
end
return {setup = _4_}
