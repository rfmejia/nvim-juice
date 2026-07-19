-- [nfnl] fnl/colors/ibm-blue.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local colors = autoload("juice.colors")
local in_gui_3f = (vim.env.WAYLAND_DISPLAY ~= nil)
local pallete
local _2_
if in_gui_3f then
  _2_ = "NONE"
else
  _2_ = "#0000A4"
end
pallete = {Background = _2_, Foreground = "#FFFF4E", Black = "#040404", DarkBlue = "#0000A4", DarkGreen = "#A8FF60", DarkCyan = "#FFFFB6", DarkRed = "#96CBFE", DarkMagenta = "#FF73FD", DarkYellow = "#C6C5FE", Gray = "#AAAAAA", DarkGray = "#6C6CAC", Blue = "#6666FF", Green = "#CEFFAC", Cyan = "#99CCFF", Red = "#FF6C60", Magenta = "#FF9CFE", Yellow = "#FFFF4E", White = "#CCCCCC"}
local groups = {Normal = {ctermfg = "Gray", ctermbg = "DarkBlue", fg = pallete.Foreground, bg = pallete.Background}, NonText = {ctermfg = "DarkBlue", fg = pallete.Background}, String = {fg = pallete.Gray}, [{"Statement", "Special"}] = {ctermfg = "White", ctermbg = "DarkBlue", fg = pallete.DarkGray, bg = pallete.Background}, Comment = {ctermfg = "Blue", ctermbg = "DarkBlue", italic = in_gui_3f, fg = pallete.Blue, bg = pallete.Background}, [{"Constant", "Type", "Preproc"}] = {ctermfg = "Cyan", fg = pallete.Cyan}, Identifier = {ctermfg = "Grey", ctermbg = "DarkBlue", fg = pallete.DarkGray}, StatusLine = {ctermfg = "Black", ctermbg = "White", fg = pallete.Black, bg = pallete.White}, WinSeparator = {ctermfg = "White", fg = pallete.White}, Visual = {ctermfg = "Black", ctermbg = "DarkCyan", fg = pallete.Black, bg = pallete.Gray}, Search = {reverse = true}, VertSplit = {ctermfg = "Black", ctermbg = "White", fg = pallete.Black, bg = pallete.White}, Directory = {ctermfg = "Green", ctermbg = "DarkBlue", fg = "Green", bg = pallete.Background}, WarningMsg = {ctermfg = "Red", ctermbg = "DarkBlue", standout = true, fg = pallete.Red, bg = pallete.Background}, Error = {ctermfg = "White", ctermbg = "Red", fg = pallete.White, bg = pallete.Red}, Cursor = {ctermfg = "Black", ctermbg = "Yellow", fg = pallete.Black, bg = pallete.Yellow}, NormalFloat = {ctermbg = "DarkBlue", bg = pallete.Background}, [{"LineNrAbove", "LineNrBelow"}] = {fg = pallete.Blue}, [{"Delimiter", "Operator", "Special", "Statement"}] = {fg = pallete.DarkGray}, CursorLine = {bg = "NONE"}, Title = {fg = "DarkCyan", underline = true}, Todo = {ctermfg = "Yellow", fg = pallete.Yellow, bold = true}, SpellBad = {fg = pallete.Red, undercurl = true}}
local diagnostic_virtual_text = {DiagnosticVirtualTextError = {fg = pallete.Red, italic = in_gui_3f}, DiagnosticVirtualTextHint = {fg = "DarkBlue", italic = in_gui_3f}, DiagnosticVirtualTextInfo = {fg = "DarkCyan", italic = in_gui_3f}, DiagnosticVirtualTextOk = {fg = "DarkGreen", italic = in_gui_3f}, DiagnosticVirtualTextWarn = {fg = "DarkYellow", italic = in_gui_3f}, LspInlayHint = {fg = pallete.DarkGray, italic = in_gui_3f}}
colors["set-hl"](groups)
colors["set-hl"](diagnostic_virtual_text)
vim.g.colors_name = "ibm-blue"
return nil
