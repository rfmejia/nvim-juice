-- [nfnl] fnl/juice/colors.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local core = autoload("nfnl.core")
--[[ "Set italic in graphical terminals" ]]
local in_gui_3f = (vim.env.WAYLAND_DISPLAY ~= nil)
local base = {StatusLineError = {fg = "DarkRed"}, StatusLineInfo = {fg = "DarkCyan"}, StatusLineWarn = {fg = "DarkYellow"}, Title = {fg = "DarkCyan", bold = true}}
local flags = {Todo = "bold", Comment = "italic", DiagnosticVirtualTextError = {"bold", "italic"}, DiagnosticVirtualTextHint = "italic", DiagnosticVirtualTextInfo = "italic", DiagnosticVirtualTextOk = "italic", DiagnosticVirtualTextWarn = "italic", LspInlayHint = "italic"}
local cleared_bg_groups = {"Normal", "CursorLine", "Pmenu", "StatusLine"}
local function hl_with_opt(name, keys)
  local group = (vim.api.nvim_get_hl(0, {name = name}) or {})
  if core["sequential?"](keys) then
    return {[name] = core["merge!"](group, core["->set"](keys))}
  elseif core["string?"](keys) then
    return {[name] = core.assoc(group, keys, true)}
  else
    return nil
  end
end
local function compute_hl_groups()
  local hl_with_opts
  do
    local tbl_26_ = {}
    local i_27_ = 0
    for k, v in pairs(flags) do
      local val_28_ = hl_with_opt(k, v)
      if (nil ~= val_28_) then
        i_27_ = (i_27_ + 1)
        tbl_26_[i_27_] = val_28_
      else
      end
    end
    hl_with_opts = tbl_26_
  end
  local cleared_opts
  local function _4_(_241)
    return {[_241] = {bg = "NONE", force = true}}
  end
  cleared_opts = core.map(_4_, cleared_bg_groups)
  local all_opts = core.concat(hl_with_opts, cleared_opts)
  return core["merge!"](base, table.unpack(all_opts))
end
local function set_hl(hi_options)
  if (nil == hi_options) then
    _G.error("Missing argument hi-options on fnl/juice/colors.fnl:36", 2)
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
local function set_colorscheme()
  local base_colors = "default"
  local custom_groups = compute_hl_groups()
  vim.cmd.colorscheme("default")
  return set_hl(custom_groups)
end
--[[ "TODO move to default-black (except setup, set-hl, other utilities)" ]]
local function setup()
  local on_background_change
  local function _7_()
    set_colorscheme()
    return nil
  end
  on_background_change = _7_
  set_colorscheme()
  return vim.api.nvim_create_autocmd("OptionSet", {pattern = "background", callback = on_background_change})
end
return {setup = setup, ["set-hl"] = set_hl}
