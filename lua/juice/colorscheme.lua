-- [nfnl] Compiled from fnl/juice/colorscheme.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
local str = autoload("nfnl.string")
local cterm_opts = {Comment = {ctermfg = "DarkGray", italic = true}, Todo = {ctermfg = "Yellow", bold = true}, CursorLineNr = {ctermfg = "White"}, [{"LineNrAbove", "LineNrBelow"}] = {ctermfg = "DarkGray"}, [{"NonText", "WinSeparator"}] = {ctermfg = "Black"}}
local diagnostic_virtual_text = {DiagnosticVirtualTextError = {ctermfg = "DarkRed", italic = true}, DiagnosticVirtualTextHint = {ctermfg = "DarkBlue", italic = true}, DiagnosticVirtualTextInfo = {ctermfg = "DarkCyan", italic = true}, DiagnosticVirtualTextOk = {ctermfg = "DarkGreen", italic = true}, DiagnosticVirtualTextWarn = {ctermfg = "DarkYellow", italic = true}}
local statusline = {StatusLine = {ctermfg = "DarkGray", ctermbg = "NONE"}, StatusLineError = {ctermfg = "DarkRed"}, StatusLineInfo = {ctermfg = "DarkCyan"}, StatusLineWarn = {ctermfg = "DarkYellow"}}
local telescope = {TelescopeSelection = {ctermfg = "White"}, TelescopeNormal = {ctermfg = "Gray"}}
local function set_hl(hi_options)
  _G.assert((nil ~= hi_options), "Missing argument hi-options on /home/rfmejia/.config/nvim/fnl/juice/colorscheme.fnl:27")
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
  vim.cmd("set notermguicolors")
  return core.map(set_hl, {cterm_opts, diagnostic_virtual_text, statusline, telescope})
end
return {setup = setup}
