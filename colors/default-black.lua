-- [nfnl] fnl/colors/default-black.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local core = autoload("nfnl.core")
--[[ "Set italic in graphical terminals" ]]
local in_gui_3f = (vim.env.WAYLAND_DISPLAY ~= nil)
local general = {Comment = {fg = "DarkYellow", ctermfg = "DarkYellow", italic = in_gui_3f}, Constant = {fg = "Green"}, CursorLine = {bg = "NONE"}, [{"Delimiter", "Operator", "Special", "Statement"}] = {fg = "Gray"}, [{"LineNrAbove", "LineNrBelow"}] = {fg = "Gray"}, NonText = {fg = "Black"}, Normal = {link = "Normal"}, NormalFloat = {link = "Normal"}, FloatBorder = {fg = "DarkYellow"}, Pmenu = {bg = "NONE"}, SpellBad = {fg = "NvimLightRed", undercurl = true}, Title = {fg = "DarkCyan", bold = true}, Todo = {fg = "Yellow", bold = true}, Visual = {reverse = true}, WinSeparator = {fg = "Gray"}}
local diagnostic_virtual_text = {DiagnosticVirtualTextError = {fg = "DarkRed", italic = in_gui_3f}, DiagnosticVirtualTextHint = {fg = "DarkBlue", italic = in_gui_3f}, DiagnosticVirtualTextInfo = {fg = "DarkCyan", italic = in_gui_3f}, DiagnosticVirtualTextOk = {fg = "DarkGreen", italic = in_gui_3f}, DiagnosticVirtualTextWarn = {fg = "DarkYellow", italic = in_gui_3f}, LspInlayHint = {fg = "Gray", italic = in_gui_3f}}
local statusline = {StatusLine = {fg = "Gray", bg = "NONE"}, StatusLineError = {fg = "DarkRed"}, StatusLineInfo = {fg = "DarkCyan"}, StatusLineWarn = {fg = "DarkYellow"}}
local function set_hl(hi_options)
  if (nil == hi_options) then
    _G.error("Missing argument hi-options on /home/rfmejia/.config/nvim/fnl/colors/default-black.fnl:36", 2)
  else
  end
  for group, settings in pairs(hi_options) do
    if core["sequential?"](group) then
      for _, sub_group in ipairs(group) do
        vim.api.nvim_set_hl(0, sub_group, settings)
      end
    elseif core["string?"](group) then
      vim.api.nvim_set_hl(0, group, settings)
    else
    end
  end
  return nil
end
core.map(set_hl, {general, diagnostic_virtual_text, statusline})
vim.g.colors_name = "default-black"
return nil
