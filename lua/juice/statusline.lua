-- [nfnl] fnl/juice/statusline.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local core = autoload("nfnl.core")
local str = autoload("nfnl.string")
local function wrap_luaeval(command)
  if (nil == command) then
    _G.error("Missing argument command on /home/rfmejia/.config/nvim/fnl/juice/statusline.fnl:5", 2)
  else
  end
  return string.format("%%{luaeval(\"%s\")}", command)
end
local function count_diagnostic(_3fbufnr, severity)
  if (nil == severity) then
    _G.error("Missing argument severity on /home/rfmejia/.config/nvim/fnl/juice/statusline.fnl:9", 2)
  else
  end
  return core.count(vim.diagnostic.get(_3fbufnr, {severity = severity}))
end
local function count_warnings()
  local case_4_ = count_diagnostic(0, vim.diagnostic.severity.WARN)
  if (case_4_ == 0) then
    return ""
  elseif (nil ~= case_4_) then
    local count = case_4_
    return ("W:" .. count .. " ")
  else
    return nil
  end
end
local function count_errors()
  local severity = vim.diagnostic.severity.ERROR
  local ws_err = count_diagnostic(nil, severity)
  local buf_err = count_diagnostic(0, severity)
  if (ws_err == 0) then
    return ""
  else
    local _ = ws_err
    return ("E:" .. buf_err .. "/" .. ws_err .. " ")
  end
end
local function get_global_var(name)
  if (nil == name) then
    _G.error("Missing argument name on /home/rfmejia/.config/nvim/fnl/juice/statusline.fnl:25", 2)
  else
  end
  local case_8_, case_9_ = pcall(vim.api.nvim_get_var, name)
  if ((case_8_ == true) and (nil ~= case_9_)) then
    local value = case_9_
    return value
  elseif ((case_8_ == false) and true) then
    local _ = case_9_
    return nil
  else
    return nil
  end
end
local function build(widgets)
  local filename = "%f"
  local buffer_modified_flags = "%m"
  local buffer_type_flags = "%q%h%r"
  local git_status = wrap_luaeval("require('juice.statusline')['get-global-var']('git_file_status')")
  local git_branch = wrap_luaeval("require('juice.statusline')['get-global-var']('git_branch')")
  local align_right = "%="
  local buf_warnings = wrap_luaeval("require('juice.statusline')['count-warnings'](vim.api.nvim_get_current_buf())")
  local ws_errors = wrap_luaeval("require('juice.statusline')['count-errors']()")
  local ruler = "%l:%c"
  local widget_str = (" " .. str.join(widgets) .. " ")
  local default_color = "%#StatusLine#"
  local info_color = "%#StatusLineInfo#"
  local error_color = "%#StatusLineError#"
  local warn_color = "%#StatusLineWarn#"
  local template = {filename, buffer_modified_flags, info_color, git_status, default_color, buffer_type_flags, align_right, info_color, widget_str, error_color, ws_errors, warn_color, buf_warnings, info_color, git_branch, default_color, " ", ruler}
  return str.join(template)
end
return {build = build, ["count-warnings"] = count_warnings, ["count-errors"] = count_errors, ["get-global-var"] = get_global_var}
