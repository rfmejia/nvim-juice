-- [nfnl] Compiled from fnl/juice/statusline.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local str = autoload("nfnl.string")
local lsp = autoload("juice.lsp")
local function wrap_luaeval(command)
  _G.assert((nil ~= command), "Missing argument command on /home/rfmejia/.config/nvim/fnl/juice/statusline.fnl:5")
  return string.format("%%{luaeval(\"%s\")}", command)
end
local function show_diagnostic_count(_3fbuf_num, severity)
  _G.assert((nil ~= severity), "Missing argument severity on /home/rfmejia/.config/nvim/fnl/juice/statusline.fnl:9")
  local count = lsp["count-diagnostic"](_3fbuf_num, severity)
  local formatted
  if (count == 0) then
    formatted = ""
  else
    formatted = (count .. "! ")
  end
  return formatted
end
local function build_statusline(widgets)
  local filename = "%f"
  local buffer_modified_flags = "%m"
  local buffer_type_flags = "%q%h%r"
  local git_status = " %{g:git_file_status}"
  local git_branch = " %{g:git_branch}"
  local align_right = "%="
  local buf_errors = wrap_luaeval("require('juice.statusline')['show-diagnostic-count'](vim.api.nvim_get_current_buf(), vim.diagnostic.severity.ERROR)")
  local buf_warnings = wrap_luaeval("require('juice.statusline')['show-diagnostic-count'](vim.api.nvim_get_current_buf(), vim.diagnostic.severity.WARN)")
  local ruler = "%l:%c"
  local widget_str = (" " .. str.join(widgets) .. " ")
  local default_color = "%#StatusLine#"
  local info_color = "%#StatusLineInfo#"
  local error_color = "%#StatusLineError#"
  local warn_color = "%#StatusLineWarn#"
  local template = {filename, buffer_modified_flags, info_color, git_status, default_color, buffer_type_flags, align_right, info_color, widget_str, error_color, buf_errors, warn_color, buf_warnings, default_color, git_branch, " ", ruler}
  local statusline = str.join(template)
  return statusline
end
return {["build-statusline"] = build_statusline, ["show-diagnostic-count"] = show_diagnostic_count}
