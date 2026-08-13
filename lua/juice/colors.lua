-- [nfnl] fnl/juice/colors.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local core = autoload("nfnl.core")
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
local function set_hl(hi_options)
  if (nil == hi_options) then
    _G.error("Missing argument hi-options on fnl/juice/colors.fnl:10", 2)
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
local function on_background_change()
  vim.cmd.colorscheme("default-black")
  return nil
end
local function setup()
  vim.api.nvim_create_autocmd("OptionSet", {pattern = "background", callback = on_background_change})
  return vim.cmd.colorscheme("default-black")
end
return {setup = setup, ["set-hl"] = set_hl, ["hl-with-opt"] = hl_with_opt}
