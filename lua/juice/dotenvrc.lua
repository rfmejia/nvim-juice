-- [nfnl] fnl/juice/dotenvrc.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local core = autoload("nfnl.core")
local str = autoload("nfnl.string")
local function read_env_pairs()
  return {makeprg = vim.env.NVIM_MAKEPRG, equalprg = vim.env.NVIM_EQUALPRG, errorformat = vim.env.NVIM_ERRORFORMAT, keywordprg = vim.env.NVIM_KEYWORDPRG, formatprg = vim.env.NVIM_FORMATPRG, wrap = ("true" == vim.env.NVIM_WRAP), tabstop = tonumber(vim.env.NVIM_TABSTOP), textwidth = tonumber(vim.env.NVIM_TEXTWIDTH), shiftwidth = tonumber(vim.env.NVIM_SHIFTWIDTH)}
end
local function read_path_list()
  if vim.env.NVIM_PATH_LIST then
    return core.concat({".", ""}, str.split(vim.env.NVIM_PATH_LIST, ":"))
  else
    return nil
  end
end
local function load_env()
  core["merge!"](vim.opt, read_env_pairs())
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
