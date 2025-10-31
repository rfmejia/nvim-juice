-- [nfnl] fnl/git-info/init.fnl
local function set_file_status_global_var()
  local path = vim.fn.expand("%:p")
  local git_cmd = ("git file-status " .. path .. " | tr -d ' \\n'")
  local case_1_, case_2_ = vim.fn.system(git_cmd)
  if (nil ~= case_1_) then
    local status = case_1_
    vim.g.git_file_status = status
    return nil
  elseif ((case_1_ == nil) and (nil ~= case_2_)) then
    local err_msg = case_2_
    return vim.notify(("[git-info] Could not get `git file-status`: " .. err_msg), vim.log.levels.ERROR)
  else
    return nil
  end
end
local function set_branch_global_var()
  local path = vim.fn.expand("%:h")
  local git_cmd = ("git -C " .. path .. " branch --show-current --no-color 2> /dev/null | tr -d ' \\n'")
  local case_4_, case_5_ = vim.fn.system(git_cmd)
  if (nil ~= case_4_) then
    local branch = case_4_
    vim.g.git_branch = branch
    return nil
  elseif ((case_4_ == nil) and (nil ~= case_5_)) then
    local err_msg = case_5_
    return vim.notify(("[git-info] Could not get `git branch`: " .. err_msg), vim.log.levels.ERROR)
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
