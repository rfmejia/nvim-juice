-- [nfnl] Compiled from fnl/juice/colorscheme.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
local str = autoload("nfnl.string")
local general = {Comment = {fg = "Gray", ctermfg = "Gray", italic = true}, Constant = {fg = "Green"}, CursorLine = {bg = "NONE"}, [{"Delimiter", "Operator", "Special", "Statement"}] = {fg = "Gray"}, [{"LineNrAbove", "LineNrBelow"}] = {fg = "Gray"}, NonText = {fg = "Black"}, Normal = {bg = "NONE"}, Title = {fg = "DarkCyan", bold = true}, Todo = {fg = "Yellow", bold = true}, WinSeparator = {fg = "Gray"}}
local diagnostic_virtual_text = {DiagnosticVirtualTextError = {fg = "DarkRed", italic = true}, DiagnosticVirtualTextHint = {fg = "DarkBlue", italic = true}, DiagnosticVirtualTextInfo = {fg = "DarkCyan", italic = true}, DiagnosticVirtualTextOk = {fg = "DarkGreen", italic = true}, DiagnosticVirtualTextWarn = {fg = "DarkYellow", italic = true}}
local statusline = {StatusLine = {fg = "Gray", bg = "NONE"}, StatusLineError = {fg = "DarkRed"}, StatusLineInfo = {fg = "DarkCyan"}, StatusLineWarn = {fg = "DarkYellow"}}
local telescope = {TelescopeSelection = {fg = "White"}, TelescopeNormal = {fg = "Gray"}}
local function set_hl(hi_options)
  _G.assert((nil ~= hi_options), "Missing argument hi-options on /home/rfmejia/.config/nvim/fnl/juice/colorscheme.fnl:31")
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
local function setup()
  vim.cmd.colorscheme("default")
  return core.map(set_hl, {general, diagnostic_virtual_text, statusline, telescope})
end
return {setup = setup}
