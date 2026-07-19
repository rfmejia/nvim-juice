-- [nfnl] fnl/juice/colors.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local core = autoload("nfnl.core")
local function set_hl(hi_options)
  if (nil == hi_options) then
    _G.error("Missing argument hi-options on fnl/juice/colors.fnl:4", 2)
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
return {["set-hl"] = set_hl}
