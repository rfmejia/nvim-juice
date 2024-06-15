-- [nfnl] Compiled from fnl/juice/git.fnl by https://github.com/Olical/nfnl, do not edit.
local function set_file_status_global_var()
  local path = vim.fn.expand("%:p")
  local git_cmd = ("git file-status " .. path .. " | tr -d ' \\n'")
  local _1_, _2_ = vim.fn.system(git_cmd)
  if (nil ~= _1_) then
    local status = _1_
    vim.g.git_file_status = status
    return nil
  elseif ((_1_ == nil) and (nil ~= _2_)) then
    local err_msg = _2_
    return print("Could not get `git file-status`: ", err_msg)
  else
    return nil
  end
end
local function set_branch_global_var()
  local path = vim.fn.expand("%:h")
  local git_cmd = ("git -C " .. path .. " branch --show-current --no-color 2> /dev/null | tr -d ' \\n'")
  local _4_, _5_ = vim.fn.system(git_cmd)
  if (nil ~= _4_) then
    local branch = _4_
    vim.g.git_branch = branch
    return nil
  elseif ((_4_ == nil) and (nil ~= _5_)) then
    local err_msg = _5_
    return print("Could not get `git branch`: ", err_msg)
  else
    return nil
  end
end
local function setup()
  local function _7_()
    set_file_status_global_var()
    return set_branch_global_var()
  end
  return vim.api.nvim_create_autocmd({"BufEnter", "BufWritePost"}, {pattern = "*", callback = _7_})
end
return {setup = setup}
