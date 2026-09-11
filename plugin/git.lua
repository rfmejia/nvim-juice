-- [nfnl] fnl/plugin/git.fnl
vim.pack.add({"https://github.com/lewis6991/gitsigns.nvim"})
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local core = autoload("nfnl.core")
local gitsigns = autoload("gitsigns")
local util = autoload("juice.util")
local function set_file_status_global_var_21()
  local path = vim.fn.expand("%:p")
  local git_cmd = ("git file-status " .. path .. " | tr -d ' \\n'")
  local case_2_, case_3_ = vim.fn.system(git_cmd)
  if (nil ~= case_2_) then
    local status = case_2_
    vim.g.git_file_status = status
    return nil
  elseif ((case_2_ == nil) and (nil ~= case_3_)) then
    local err_msg = case_3_
    return vim.notify(("[git-info] Could not get `git file-status`: " .. err_msg), vim.log.levels.ERROR)
  else
    return nil
  end
end
local function set_branch_global_var_21()
  local path = vim.fn.expand("%:h")
  local git_cmd = ("git -C " .. path .. " branch --show-current --no-color 2> /dev/null | tr -d ' \\n'")
  local case_5_, case_6_ = vim.fn.system(git_cmd)
  if (nil ~= case_5_) then
    local branch = case_5_
    vim.g.git_branch = branch
    return nil
  elseif ((case_5_ == nil) and (nil ~= case_6_)) then
    local err_msg = case_6_
    return vim.notify(("[git-info] Could not get `git branch`: " .. err_msg), vim.log.levels.ERROR)
  else
    return nil
  end
end
local nav_maps
local function _8_()
  return gitsigns.nav_hunk("next", {preview = true, target = "all", wrap = false})
end
local function _9_()
  return gitsigns.nav_hunk("prev", {preview = true, target = "all", wrap = false})
end
nav_maps = {{"n", "]g", _8_, {desc = "[gitsigns] jump to next git hunk"}}, {"n", "[g", _9_, {desc = "[gitsigns] jump to previous git hunk"}}}
local toggle_signs
local function _10_(_241)
  if (gitsigns.toggle_signs(_241) and ("no" == vim.o.signcolumn)) then
    vim.opt.signcolumn = "yes"
    return nil
  else
    return nil
  end
end
toggle_signs = _10_
local staging_maps
local function _12_()
  return gitsigns.stage_hunk({[vim.fn.line(".")] = vim.fn.line("v")})
end
local function _13_()
  return gitsigns.reset_hunk({[vim.fn.line(".")] = vim.fn.line("v")})
end
staging_maps = {{"n", "<localleader>gs", gitsigns.stage_hunk, {desc = "[gitsigns] (g)it (s)tage hunk"}}, {"n", "<localleader>gr", gitsigns.reset_hunk, {desc = "(g)it (r)eset hunk"}}, {"n", "<localleader>gS", gitsigns.stage_buffer, {desc = "[gitsigns] (g)it (S)tage buffer"}}, {"n", "<localleader>gR", gitsigns.reset_buffer, {desc = "[gitsigns] (g)it (R)eset buffer"}}, {"v", "<localleader>gs", _12_, {desc = "[gitsigns] (g)it (s)tage hunk"}}, {"v", "<localleader>gr", _13_, {desc = "[gitsigns] (g)it (r)eset hunk"}}}
local blame_maps
local function _14_()
  return gitsigns.blame_line({full = true})
end
blame_maps = {{"n", "<localleader>gb", _14_, {desc = "[gitsigns] (g)it show line (b)lame"}}, {"n", "<localleader>gB", gitsigns.toggle_current_line_blame, {desc = "[gitsigns] (g)it toggle current line (B)lame"}}}
local view_maps = {{"n", "<localleader>gt", toggle_signs, {desc = "[gitsigns] toggle sign visibility"}}, {"n", "<localleader>gp", gitsigns.preview_hunk, {desc = "[gitsigns] (g)it (p)review hunk"}}, {"n", "<localleader>gi", gitsigns.preview_hunk_inline, {desc = "[gitsigns] (g)it toggle (D)eleted hunks"}}, {"n", "<localleader>gd", gitsigns.diffthis, {desc = "[gitsigns] (g)it show (d)iff"}}}
local list_maps
local function _15_()
  return gitsigns.setqflist("all")
end
list_maps = {{"n", "<localleader>gl", gitsigns.setloclist, {desc = "[gitsigns] show buffer (g)it hunks in (l)oclist"}}, {"n", "<localleader>gc", _15_, {desc = "[gitsigns] show all (g)it hunks in qui(c)kfix list"}}}
local keymaps = core.concat(nav_maps, staging_maps, blame_maps, view_maps, list_maps)
util["set-keys"](keymaps)
toggle_signs(false)
local function _16_()
  set_file_status_global_var_21()
  return set_branch_global_var_21()
end
return vim.api.nvim_create_autocmd({"BufEnter", "BufWritePost"}, {pattern = "*", callback = _16_})
