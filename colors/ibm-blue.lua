-- [nfnl] fnl/colors/ibm-blue.fnl
local in_gui_3f = (vim.env.WAYLAND_DISPLAY ~= nil)
local pallete
local _1_
if in_gui_3f then
  _1_ = "NONE"
else
  _1_ = "#0000A4"
end
pallete = {Background = _1_, Foreground = "#FFFF4E", Black = "#040404", DarkBlue = "#0000A4", DarkGreen = "#A8FF60", DarkCyan = "#FFFFB6", DarkRed = "#96CBFE", DarkMagenta = "#FF73FD", DarkYellow = "#C6C5FE", Gray = "#AAAAAA", DarkGray = "#6C6CAC", Blue = "#6666FF", Green = "#CEFFAC", Cyan = "#99CCFF", Red = "#FF6C60", Magenta = "#FF9CFE", Yellow = "#FFFF4E", White = "#CCCCCC"}
local groups = {Normal = {ctermfg = "Gray", ctermbg = "DarkBlue", fg = pallete.Foreground, bg = pallete.Background}, NonText = {ctermfg = "DarkBlue", fg = pallete.Background}, String = {fg = pallete.Gray}, [{"Statement", "Special"}] = {ctermfg = "White", ctermbg = "DarkBlue", fg = pallete.DarkGray, bg = pallete.Background}, Comment = {ctermfg = "Blue", ctermbg = "DarkBlue", italic = in_gui_3f, fg = pallete.Blue, bg = pallete.Background}, [{"Constant", "Type", "Preproc"}] = {ctermfg = "Cyan", fg = pallete.Cyan}, Identifier = {ctermfg = "Grey", ctermbg = "DarkBlue", fg = pallete.DarkGray}, StatusLine = {ctermfg = "Black", ctermbg = "White", fg = pallete.Black, bg = pallete.White}, WinSeparator = {ctermfg = "White", fg = pallete.White}, Visual = {ctermfg = "Black", ctermbg = "DarkCyan", fg = pallete.Black, bg = pallete.Gray}, Search = {reverse = true}, VertSplit = {ctermfg = "Black", ctermbg = "White", fg = pallete.Black, bg = pallete.White}, Directory = {ctermfg = "Green", ctermbg = "DarkBlue", fg = "Green", bg = pallete.Background}, WarningMsg = {ctermfg = "Red", ctermbg = "DarkBlue", standout = true, fg = pallete.Red, bg = pallete.Background}, Error = {ctermfg = "White", ctermbg = "Red", fg = pallete.White, bg = pallete.Red}, Cursor = {ctermfg = "Black", ctermbg = "Yellow", fg = pallete.Black, bg = pallete.Yellow}, NormalFloat = {ctermbg = "DarkBlue", bg = pallete.Background}, [{"LineNrAbove", "LineNrBelow"}] = {fg = pallete.Blue}, [{"Delimiter", "Operator", "Special", "Statement"}] = {fg = pallete.DarkGray}, CursorLine = {bg = "NONE"}, Title = {fg = "DarkCyan", underline = true}, Todo = {ctermfg = "Yellow", fg = pallete.Yellow, bold = true}, SpellBad = {fg = pallete.Red, undercurl = true}}
local diagnostic_virtual_text = {DiagnosticVirtualTextError = {fg = pallete.Red, italic = in_gui_3f}, DiagnosticVirtualTextHint = {fg = "DarkBlue", italic = in_gui_3f}, DiagnosticVirtualTextInfo = {fg = "DarkCyan", italic = in_gui_3f}, DiagnosticVirtualTextOk = {fg = "DarkGreen", italic = in_gui_3f}, DiagnosticVirtualTextWarn = {fg = "DarkYellow", italic = in_gui_3f}, LspInlayHint = {fg = "Gray", italic = in_gui_3f}}
local function set_hl(hi_options)
  if (nil == hi_options) then
    _G.error("Missing argument hi-options on /home/rfmejia/.config/nvim/fnl/colors/ibm-blue.fnl:108", 2)
  else
  end
  local _let_4_ = require("nfnl.module")
  local autoload = _let_4_.autoload
  local core = autoload("nfnl.core")
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
set_hl(groups)
set_hl(diagnostic_virtual_text)
vim.g.colors_name = "ibm-blue"
return nil
