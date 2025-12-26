-- [nfnl] fnl/juice/packs/editing.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local pack = autoload("pack")
local util = autoload("juice.util")
local function _2_()
  pack.add({{src = "https://github.com/windwp/nvim-autopairs"}, {src = "https://github.com/kylechui/nvim-surround"}})
  local function _3_()
    return util["call-setup"]("nvim-surround")
  end
  pack["load-on-keymap"]("nvim-surround", {"cs", "ds", "ys"}, _3_)
  local function _4_()
    return util.call("nvim-autopairs", "setup", {enable_check_bracket_line = false})
  end
  return pack["load-on-event"]("nvim-autopairs", "InsertEnter", {desc = "Lazily load nvim-autopairs", callback = _4_})
end
return {setup = _2_}
