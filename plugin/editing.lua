-- [nfnl] fnl/plugin/editing.fnl
vim.pack.add({"https://github.com/windwp/nvim-autopairs", "https://github.com/kylechui/nvim-surround"})
local _let_1_ = require("nfnl.module")
local autoload = _let_1_.autoload
local util = autoload("juice.util")
local autopairs_opts = {enable_check_bracket_line = false}
return util.call("nvim-autopairs", "setup", autopairs_opts)
