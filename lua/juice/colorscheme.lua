-- [nfnl] fnl/juice/colorscheme.fnl
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
    _G.error("Missing argument hi-options on /home/rfmejia/.config/nvim/fnl/juice/colorscheme.fnl:33", 2)
  else
  end
  for hi_group, opts in pairs(hi_options) do
    if core["sequential?"](hi_group) then
      for _, sub_group in ipairs(hi_group) do
        vim.api.nvim_set_hl(0, sub_group, opts)
      end
    elseif core["string?"](hi_group) then
      vim.api.nvim_set_hl(0, hi_group, opts)
    else
    end
  end
  return nil
end
local function _4_()
  vim.cmd.colorscheme("default")
  return core.map(set_hl, {general, diagnostic_virtual_text, statusline})
end
return {setup = _4_}
