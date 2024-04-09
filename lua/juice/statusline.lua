-- [nfnl] Compiled from fnl/juice/statusline.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local function git_file_status()
  local path = vim.fn.expand("%:p")
  local git_cmd = ("git file-status " .. path .. " | tr -d ' \\n'")
  --[[ "TODO Check: if directory then set to blank" ]]
  local _2_, _3_ = vim.fn.system(git_cmd)
  if (nil ~= _2_) then
    local status = _2_
    vim.g.git_file_status = status
    return nil
  elseif ((_2_ == nil) and (nil ~= _3_)) then
    local err_msg = _3_
    return print("Could not get `git file-status`: ", err_msg)
  else
    return nil
  end
end
local function git_branch()
  local path = vim.fn.expand("%:h")
  local git_cmd = ("git -C " .. path .. " branch --show-current --no-color 2> /dev/null | tr -d ' \\n'")
  local _5_, _6_ = vim.fn.system(git_cmd)
  if (nil ~= _5_) then
    local branch = _5_
    vim.g.git_branch = branch
    return nil
  elseif ((_5_ == nil) and (nil ~= _6_)) then
    local err_msg = _6_
    return print("Could not get `git branch`: ", err_msg)
  else
    return nil
  end
end
local function count_diagnostic(severity)
  local a = autoload("nfnl.core")
  local count = a.count(vim.diagnostic.get(0, {severity = severity}))
  if (count > 0) then
    return (count .. "! ")
  else
    return ""
  end
end
local function build_statusline(widgets)
  local s = autoload("nfnl.string")
  local u = autoload("juice.util")
  local filename = "%f"
  local buffer_modified_flags = "%m"
  local buffer_type_flags = "%q%h%r"
  local git_status = " %{g:git_file_status}"
  local git_branch0 = " %{g:git_branch}"
  local align_right = "%="
  local errors = u["lua-statusline"]("require('juice.statusline')['count-diagnostic'](vim.diagnostic.severity.ERROR)")
  local warnings = u["lua-statusline"]("require('juice.statusline')['count-diagnostic'](vim.diagnostic.severity.WARN)")
  local ruler = "%l:%c"
  local widget_str = (" " .. s.join(widgets) .. " ")
  local default_color = "%#StatusLine#"
  local info_color = "%#StatusLineInfo#"
  local error_color = "%#StatusLineError#"
  local warn_color = "%#StatusLineWarn#"
  local template = {filename, buffer_modified_flags, info_color, git_status, default_color, buffer_type_flags, align_right, widget_str, error_color, errors, warn_color, warnings, info_color, git_branch0, " ", default_color, ruler}
  local statusline = s.join(template)
  return statusline
end
return {["git-file-status"] = git_file_status, ["git-branch"] = git_branch, ["count-diagnostic"] = count_diagnostic, ["build-statusline"] = build_statusline}
