-- [nfnl] fnl/juice/dotenvrc.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local core = autoload("nfnl.core")
local string = autoload("nfnl.string")
--[[ "TODO" "Load the following special envs" ["split to sbtn or scala-cli" "dadbod"] ]]
local function read_env_pairs()
  return {makeprg = vim.env.NVIM_MAKEPRG, errorformat = vim.env.NVIM_ERRORFORMAT, keywordprg = vim.env.NVIM_KEYWORDPRG, formatprg = vim.env.NVIM_FORMATPRG, wrap = ("true" == vim.env.NVIM_WRAP), tabstop = tonumber(vim.env.NVIM_TEXTWIDTH), textwidth = tonumber(vim.env.NVIM_TEXTWIDTH), shiftwidth = tonumber(vim.env.NVIM_SHIFTWIDTH)}
end
local function read_path_list()
  if vim.env.NVIM_PATH_LIST then
    return core.concat({".", ""}, string.split(vim.env.NVIM_PATH_LIST, ":"))
  else
    return nil
  end
end
local function load_env()
  for name, setting in pairs(read_env_pairs()) do
    vim.opt[name] = setting
  end
  local case_3_ = read_path_list()
  if (nil ~= case_3_) then
    local path_list = case_3_
    vim.opt.path = path_list
    return nil
  else
    return nil
  end
end
return {setup = load_env, ["read-path-list"] = read_path_list, ["load-env"] = load_env}
