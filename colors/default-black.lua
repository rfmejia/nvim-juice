-- [nfnl] fnl/colors/default-black.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local core = autoload("nfnl.core")
local colors = autoload("juice.colors")
--[[ "Set italic in graphical terminals" ]]
local in_gui_3f = (vim.env.WAYLAND_DISPLAY ~= nil)
local base = {StatusLineError = {fg = "DarkRed"}, StatusLineInfo = {fg = "DarkCyan"}, StatusLineWarn = {fg = "DarkYellow"}, Title = {fg = "DarkCyan", bold = true}}
local flags = {Todo = "bold", Comment = "italic", DiagnosticVirtualTextError = {"bold", "italic"}, DiagnosticVirtualTextHint = "italic", DiagnosticVirtualTextInfo = "italic", DiagnosticVirtualTextOk = "italic", DiagnosticVirtualTextWarn = "italic", LspInlayHint = "italic"}
local cleared_bg_groups = {"Normal", "NormalFloat", "CursorLine", "Pmenu", "StatusLine"}
local function compute_hl_groups()
  local hl_with_opts
  do
    local tbl_26_ = {}
    local i_27_ = 0
    for k, v in pairs(flags) do
      local val_28_ = colors["hl-with-opt"](k, v)
      if (nil ~= val_28_) then
        i_27_ = (i_27_ + 1)
        tbl_26_[i_27_] = val_28_
      else
      end
    end
    hl_with_opts = tbl_26_
  end
  local cleared_opts
  local function _3_(_241)
    return {[_241] = {bg = "NONE", force = true}}
  end
  cleared_opts = core.map(_3_, cleared_bg_groups)
  local all_opts = core.concat(hl_with_opts, cleared_opts)
  return core["merge!"](base, table.unpack(all_opts))
end
vim.cmd.colorscheme("default")
colors["set-hl"](compute_hl_groups())
vim.g.colors_name = "default-black"
return nil
