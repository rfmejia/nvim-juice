-- [nfnl] fnl/plugin/editing.fnl
local _let_1_ = require("nfnl.module")
local autoload = _let_1_.autoload
local pacman = autoload("pacman")
local util = autoload("juice.util")
local packs = {"https://github.com/windwp/nvim-autopairs", "https://github.com/kylechui/nvim-surround"}
local autopairs_opts = {enable_check_bracket_line = false}
pacman.add(packs)
pacman["load-on-keymap"]("nvim-surround", {"cs", "ds", "ys"})
local function _2_()
  return util.call("nvim-autopairs", "setup", autopairs_opts)
end
return pacman["load-on-event"]("nvim-autopairs", "InsertEnter", {desc = "Lazily load nvim-autopairs", callback = _2_})
