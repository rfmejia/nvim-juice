-- [nfnl] fnl/plugin/git.fnl
vim.pack.add({"https://github.com/lewis6991/gitsigns.nvim"})
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
local _let_7_ = require("nfnl.module")
local autoload = _let_7_.autoload
local core = autoload("nfnl.core")
local gitsigns = autoload("gitsigns")
local util = autoload("juice.util")
local nav_maps
local function _8_()
  return gitsigns.nav_hunk("next", {preview = true, target = "all", wrap = false})
end
local function _9_()
  return gitsigns.nav_hunk("prev", {preview = true, target = "all", wrap = false})
end
nav_maps = {{"n", "]g", _8_, {desc = "[gitsigns] jump to next git hunk"}}, {"n", "[g", _9_, {desc = "[gitsigns] jump to previous git hunk"}}}
local staging_maps
local function _10_()
  return gitsigns.stage_hunk({[vim.fn.line(".")] = vim.fn.line("v")})
end
local function _11_()
  return gitsigns.reset_hunk({[vim.fn.line(".")] = vim.fn.line("v")})
end
staging_maps = {{"n", "<localleader>gs", gitsigns.stage_hunk, {desc = "[gitsigns] (g)it (s)tage hunk"}}, {"n", "<localleader>gr", gitsigns.reset_hunk, {desc = "(g)it (r)eset hunk"}}, {"n", "<localleader>gS", gitsigns.stage_buffer, {desc = "[gitsigns] (g)it (S)tage buffer"}}, {"n", "<localleader>gR", gitsigns.reset_buffer, {desc = "[gitsigns] (g)it (R)eset buffer"}}, {"v", "<localleader>gs", _10_, {desc = "[gitsigns] (g)it (s)tage hunk"}}, {"v", "<localleader>gr", _11_, {desc = "[gitsigns] (g)it (r)eset hunk"}}}
local blame_maps
local function _12_()
  return gitsigns.blame_line({full = true})
end
blame_maps = {{"n", "<localleader>gb", _12_, {desc = "[gitsigns] (g)it show line (b)lame"}}, {"n", "<localleader>gB", gitsigns.toggle_current_line_blame, {desc = "[gitsigns] (g)it toggle current line (B)lame"}}}
local view_maps = {{"n", "<localleader>gt", gitsigns.toggle_signs, {desc = "[gitsigns] toggle sign visibility"}}, {"n", "<localleader>gp", gitsigns.preview_hunk, {desc = "[gitsigns] (g)it (p)review hunk"}}, {"n", "<localleader>gi", gitsigns.preview_hunk_inline, {desc = "[gitsigns] (g)it toggle (D)eleted hunks"}}, {"n", "<localleader>gd", gitsigns.diffthis, {desc = "[gitsigns] (g)it show (d)iff"}}}
local list_maps
local function _13_()
  return gitsigns.setqflist("all")
end
list_maps = {{"n", "<localleader>gl", gitsigns.setloclist, {desc = "[gitsigns] show buffer (g)it hunks in (l)oclist"}}, {"n", "<localleader>gc", _13_, {desc = "[gitsigns] show all (g)it hunks in qui(c)kfix list"}}}
local keymaps = core.concat(nav_maps, staging_maps, blame_maps, view_maps, list_maps)
util["set-keys"](keymaps)
gitsigns.toggle_signs(false)
if ("no" == vim.o.signcolumn) then
  vim.opt.signcolumn = "yes"
else
end
local function _15_()
  set_file_status_global_var()
  return set_branch_global_var()
end
return vim.api.nvim_create_autocmd({"BufEnter", "BufWritePost"}, {pattern = "*", callback = _15_})
