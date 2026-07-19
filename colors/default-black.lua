-- [nfnl] fnl/colors/default-black.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local core = autoload("nfnl.core")
local colors = autoload("juice.colors")
--[[ "Set italic in graphical terminals" ]]
local in_gui_3f = (vim.env.WAYLAND_DISPLAY ~= nil)
local general = {Comment = {fg = "Gray", ctermfg = "DarkYellow", italic = in_gui_3f}, Constant = {fg = "Green"}, CursorLine = {bg = "NONE"}, [{"Delimiter", "Operator", "Special", "Statement"}] = {fg = "Gray"}, [{"LineNrAbove", "LineNrBelow"}] = {fg = "Gray"}, NonText = {fg = "Black"}, Normal = {link = "Normal"}, NormalFloat = {link = "Normal"}, FloatBorder = {fg = "DarkYellow"}, Pmenu = {bg = "NONE"}, SpellBad = {fg = "NvimLightRed", undercurl = true}, Title = {fg = "DarkCyan", bold = true}, Todo = {fg = "Yellow", bold = true}, Visual = {reverse = true}, WinSeparator = {fg = "Gray"}}
local diagnostic_virtual_text = {DiagnosticVirtualTextError = {fg = "DarkRed", italic = in_gui_3f}, DiagnosticVirtualTextHint = {fg = "DarkBlue", italic = in_gui_3f}, DiagnosticVirtualTextInfo = {fg = "DarkCyan", italic = in_gui_3f}, DiagnosticVirtualTextOk = {fg = "DarkGreen", italic = in_gui_3f}, DiagnosticVirtualTextWarn = {fg = "DarkYellow", italic = in_gui_3f}, LspInlayHint = {fg = "Gray", italic = in_gui_3f}}
local statusline = {StatusLine = {fg = "Gray", bg = "NONE"}, StatusLineError = {fg = "DarkRed"}, StatusLineInfo = {fg = "DarkCyan"}, StatusLineWarn = {fg = "DarkYellow"}}
core.map(colors["set-hl"], {general, diagnostic_virtual_text, statusline})
vim.g.colors_name = "default-black"
return nil
