-- [nfnl] fnl/colors/default-black.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local core = autoload("nfnl.core")
--[[ "Set italic in graphical terminals" ]]
local is_gui = (vim.env.WAYLAND_DISPLAY ~= nil)
local general = {Comment = {fg = "DarkYellow", ctermfg = "DarkYellow", italic = is_gui}, Constant = {fg = "Green"}, CursorLine = {bg = "NONE"}, [{"Delimiter", "Operator", "Special", "Statement"}] = {fg = "Gray"}, [{"LineNrAbove", "LineNrBelow"}] = {fg = "Gray"}, NonText = {fg = "Black"}, Normal = {bg = "NONE"}, SpellBad = {fg = "NvimLightRed", undercurl = true}, Title = {fg = "DarkCyan", bold = true}, Todo = {fg = "Yellow", bold = true}, Visual = {reverse = true}, WinSeparator = {fg = "Gray"}}
local diagnostic_virtual_text = {DiagnosticVirtualTextError = {fg = "DarkRed", italic = is_gui}, DiagnosticVirtualTextHint = {fg = "DarkBlue", italic = is_gui}, DiagnosticVirtualTextInfo = {fg = "DarkCyan", italic = is_gui}, DiagnosticVirtualTextOk = {fg = "DarkGreen", italic = is_gui}, DiagnosticVirtualTextWarn = {fg = "DarkYellow", italic = is_gui}, LspInlayHint = {fg = "Gray", italic = is_gui}}
local statusline = {StatusLine = {fg = "Gray", bg = "NONE"}, StatusLineError = {fg = "DarkRed"}, StatusLineInfo = {fg = "DarkCyan"}, StatusLineWarn = {fg = "DarkYellow"}}
local function set_hl(hi_options)
  if (nil == hi_options) then
    _G.error("Missing argument hi-options on /home/rfmejia/.config/nvim/fnl/colors/default-black.fnl:33", 2)
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
return core.map(set_hl, {general, diagnostic_virtual_text, statusline})
