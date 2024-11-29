-- [nfnl] Compiled from fnl/juice/dotenvrc.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local string = autoload("nfnl.string")
local util = autoload("juice.util")
--[[ "TODO" ["split to sbtn or scala-cli" "dadbod"] ]]
local function read_env_pairs()
  return {makeprg = vim.env.NVIM_MAKEPRG, errorformat = vim.env.NVIM_ERRORFORMAT, keywordprg = vim.env.NVIM_KEYWORDPRG, formatprg = vim.env.NVIM_FORMATPRG}
end
local function set_path_list(path_list)
  _G.assert((nil ~= path_list), "Missing argument path-list on /home/rfmejia/.config/nvim/fnl/juice/dotenvrc.fnl:15")
  local paths = string.split(path_list, ":")
  vim.opt.path = {".", ""}
  for _, path in ipairs(paths) do
    vim.opt.path:append(path)
  end
  return nil
end
local function setup()
  util["assoc-in"](vim.opt, read_env_pairs())
  if vim.env.NVIM_PATH_LIST then
    return set_path_list(vim.env.NVIM_PATH_LIST)
  else
    return nil
  end
end
return {setup = setup}
