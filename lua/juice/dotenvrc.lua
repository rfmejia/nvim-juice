-- [nfnl] Compiled from fnl/juice/dotenvrc.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
local string = autoload("nfnl.string")
local util = autoload("juice.util")
--[[ "TODO" ["split to sbtn or scala-cli" "dadbod"] ]]
local function read_env_pairs()
  return {makeprg = vim.env.NVIM_MAKEPRG, errorformat = vim.env.NVIM_ERRORFORMAT, keywordprg = vim.env.NVIM_KEYWORDPRG, formatprg = vim.env.NVIM_FORMATPRG}
end
local function read_path_list()
  if vim.env.NVIM_PATH_LIST then
    return core.concat({".", ""}, string.split(vim.env.NVIM_PATH_LIST, ":"))
  else
    return nil
  end
end
local function setup()
  util["assoc-in"](vim.opt, read_env_pairs())
  local tmp_6_auto = read_path_list()
  if (tmp_6_auto ~= nil) then
    vim.opt.path = tmp_6_auto
    return nil
  else
    return nil
  end
end
return {setup = setup, ["read-path-list"] = read_path_list}
