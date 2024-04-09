-- [nfnl] Compiled from fnl/juice/colors.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = autoload("juice.util")
local executable_3f = _local_2_["executable?"]
local function color_attr(hl_group, attribute)
  return (vim.api.nvim_get_hl(0, {name = hl_group}))[attribute]
end
local custom_colors = {["normal-bg"] = color_attr("Normal", "bg"), ["info-fg"] = color_attr("DiagnosticInfo", "fg"), ["error-fg"] = color_attr("DiagnosticError", "fg"), ["warn-fg"] = color_attr("DiagnosticWarn", "fg"), ["statusline-bg"] = color_attr("StatusLine", "bg"), ["dark-gray"] = "#3d3d3d", ["darker-gray"] = "#1d1d1d", ["dark-green"] = "#009000", ["light-gray"] = "#707070"}
local c = custom_colors
local groups = {Comment = {fg = c["light-gray"], style = "italic"}, Conceal = {link = "Comment"}, CursorLine = {bg = c["normal-bg"]}, CursorLineNr = {link = "Normal"}, DiagnosticVirtualTextError = {fg = c["error-fg"], style = "italic"}, DiagnosticVirtualTextWarn = {fg = c["warn-fg"], style = "italic"}, ExtraWhitespace = {fg = c["error-fg"], undercurl = true}, FloatBorder = {fg = c["light-gray"]}, LineNr = {fg = c["dark-gray"], bg = c["cursor-bg"]}, LineNrAbove = {fg = c["dark-gray"], bg = c["normal-bg"]}, LineNrBelow = {fg = c["dark-gray"], bg = c["normal-bg"]}, MsgArea = {fg = c["light-gray"]}, NormalFloat = {bg = c["normal-bg"]}, SpellBad = {fg = c["warn-fg"], style = "undercurl"}, StatusLine = {fg = c["light-gray"], bg = c["normal-bg"]}, StatusLineInfo = {fg = c["info-fg"], bg = c["statusline-bg"]}, StatusLineError = {fg = c["error-fg"], bg = c["statusline-bg"]}, StatusLineWarn = {fg = c["warn-fg"], bg = c["statusline-bg"]}, TelescopeSelection = {bg = c["darker-gray"]}, Todo = {link = "ModeMsg"}, WinSeparator = {fg = c["dark-green"], bg = c["normal-bg"]}}
local function show_extra_whitespace()
  return vim.api.nvim_set_hl(0, "ExtraWhitespace", groups.ExtraWhitespace)
end
local function get_gnome_colorscheme(dark_scheme, light_scheme)
  local gsettings_cmd = {"gsettings", "get", "org.gnome.desktop.interface", "color-scheme"}
  if executable_3f("gsettings") then
    local system_theme = vim.fn.system(gsettings_cmd)
    if (string.find(system_theme, "default") or string.find(system_theme, "prefer-light")) then
      return light_scheme
    else
      return dark_scheme
    end
  else
    return dark_scheme
  end
end
local function setup()
  local theme = autoload("github-theme")
  local options = {transparent = true}
  theme.setup({options = options, groups = {all = groups}})
  --[[ vim.cmd.colorscheme (get-gnome-colorscheme "github_dark" "github_light") ]]
  return vim.cmd.colorscheme("github_dark")
end
return {["show-extra-whitespace"] = show_extra_whitespace, setup = setup}
