-- [nfnl] fnl/juice/dotenvrc.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
local string = autoload("nfnl.string")
--[[ "TODO" "Load the following special envs" ["split to sbtn or scala-cli" "dadbod"] ]]
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
local function read_copilot_workspaces()
  if vim.env.NVIM_COPILOT_WORKSPACES then
    return string.split(vim.env.NVIM_COPILOT_WORKSPACES, ":")
  else
    return nil
  end
end
local function load_env()
  core["merge!"](vim.opt, read_env_pairs())
  do
    local tmp_6_ = read_path_list()
    if (tmp_6_ ~= nil) then
      vim.opt.path = tmp_6_
    else
    end
  end
  local _5_ = read_copilot_workspaces()
  if (nil ~= _5_) then
    local workspaces = _5_
    vim.g.copilot_workspace_folders = core.distinct(core.concat(vim.g.copilot_workspace_folders, workspaces))
    return nil
  else
    return nil
  end
end
return {setup = load_env, ["read-path-list"] = read_path_list, ["load-env"] = load_env}
