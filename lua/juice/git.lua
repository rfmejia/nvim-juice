-- [nfnl] Compiled from fnl/juice/git.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local notify = autoload("nfnl.notify")
local function set_file_status_global_var()
  local path = vim.fn.expand("%:p")
  local git_cmd = ("git file-status " .. path .. " | tr -d ' \\n'")
  local _2_, _3_ = vim.fn.system(git_cmd)
  if (nil ~= _2_) then
    local status = _2_
    vim.g.git_file_status = status
    return nil
  elseif ((_2_ == nil) and (nil ~= _3_)) then
    local err_msg = _3_
    return notify.error("Could not get `git file-status`: ", err_msg)
  else
    return nil
  end
end
local function set_branch_global_var()
  local path = vim.fn.expand("%:h")
  local git_cmd = ("git -C " .. path .. " branch --show-current --no-color 2> /dev/null | tr -d ' \\n'")
  local _5_, _6_ = vim.fn.system(git_cmd)
  if (nil ~= _5_) then
    local branch = _5_
    vim.g.git_branch = branch
    return nil
  elseif ((_5_ == nil) and (nil ~= _6_)) then
    local err_msg = _6_
    return notify.error("Could not get `git branch`: ", err_msg)
  else
    return nil
  end
end
local function setup()
  local function _8_()
    set_file_status_global_var()
    return set_branch_global_var()
  end
  return vim.api.nvim_create_autocmd({"BufEnter", "BufWritePost"}, {pattern = "*", callback = _8_})
end
return {setup = setup}
