-- [nfnl] fnl/plugin/editing.fnl
vim.pack.add({"https://github.com/windwp/nvim-autopairs", "https://github.com/kylechui/nvim-surround", "https://codeberg.org/andyg/leap.nvim"})
local _let_1_ = require("nfnl.module")
local autoload = _let_1_.autoload
local util = autoload("juice.util")
local autopairs = autoload("nvim-autopairs")
local autopairs_opts = {enable_check_bracket_line = false}
local leap_maps = {{{"n", "x", "o"}, "s", "<Plug>(leap)"}, {"n", "S", "<Plug>(leap-from-window)"}}
autopairs.setup(autopairs_opts)
return util["set-keys"](leap_maps)
