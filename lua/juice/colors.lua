-- [nfnl] Compiled from fnl/juice/colors.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local gh_theme = autoload("github-theme")
local util = autoload("juice.util")
local function color_attr(hl_group, attribute)
  _G.assert((nil ~= attribute), "Missing argument attribute on /home/rfmejia/.config/nvim/fnl/juice/colors.fnl:5")
  _G.assert((nil ~= hl_group), "Missing argument hl-group on /home/rfmejia/.config/nvim/fnl/juice/colors.fnl:5")
  return vim.api.nvim_get_hl(0, {name = hl_group})[attribute]
end
local custom_colors = {["normal-bg"] = "#000000", ["info-fg"] = color_attr("DiagnosticInfo", "fg"), ["error-fg"] = color_attr("DiagnosticError", "fg"), ["warn-fg"] = color_attr("DiagnosticWarn", "fg"), ["hint-fg"] = color_attr("DiagnosticHint", "fg"), ["ok-fg"] = color_attr("DiagnosticOk", "fg"), ["statusline-bg"] = "#000000", ["dark-gray"] = "#3d3d3d", ["darker-gray"] = "#1d1d1d", ["dark-green"] = "#009000", ["light-gray"] = "#707070"}
local c = custom_colors
local custom_groups = {Comment = {fg = c["light-gray"], style = "italic"}, Conceal = {link = "Comment"}, CursorLine = {bg = c["normal-bg"]}, CursorLineNr = {link = "Normal"}, DiagnosticVirtualTextError = {fg = c["error-fg"], style = "italic"}, DiagnosticVirtualTextWarn = {fg = c["warn-fg"], style = "italic"}, DiagnosticVirtualTextHint = {fg = c["hint-fg"], style = "italic"}, DiagnosticVirtualTextInfo = {fg = c["info-fg"], style = "italic"}, DiagnosticVirtualTextOk = {fg = c["ok-fg"], style = "italic"}, FloatBorder = {fg = c["light-gray"]}, LineNr = {fg = c["dark-gray"], bg = c["cursor-bg"]}, LineNrAbove = {fg = c["dark-gray"], bg = c["normal-bg"]}, LineNrBelow = {fg = c["dark-gray"], bg = c["normal-bg"]}, MsgArea = {fg = c["light-gray"]}, Normal = {bg = c["normal-bg"]}, NormalFloat = {bg = c["normal-bg"]}, SpellBad = {fg = c["warn-fg"], style = "undercurl"}, StatusLine = {fg = c["light-gray"], bg = c["normal-bg"]}, StatusLineInfo = {fg = c["info-fg"], bg = c["statusline-bg"]}, StatusLineError = {fg = c["error-fg"], bg = c["statusline-bg"]}, StatusLineWarn = {fg = c["warn-fg"], bg = c["statusline-bg"]}, TelescopeSelection = {bg = c["darker-gray"]}, Todo = {link = "ModeMsg"}, WinSeparator = {fg = c["dark-green"], bg = c["normal-bg"]}}
local function get_gnome_colorscheme(dark_scheme, light_scheme)
  _G.assert((nil ~= light_scheme), "Missing argument light-scheme on /home/rfmejia/.config/nvim/fnl/juice/colors.fnl:49")
  _G.assert((nil ~= dark_scheme), "Missing argument dark-scheme on /home/rfmejia/.config/nvim/fnl/juice/colors.fnl:49")
  local gsettings_cmd = {"gsettings", "get", "org.gnome.desktop.interface", "color-scheme"}
  if util["executable?"]("gsettings") then
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
  local groups = {github_dark = custom_groups}
  local options = {transparent = true}
  gh_theme.setup({options = options, groups = groups})
  --[[ vim.cmd.colorscheme (get-gnome-colorscheme "github_dark" "github_light") ]]
  return vim.cmd.colorscheme("github_dark")
end
return {setup = setup, ["color-attr"] = color_attr}
