-- [nfnl] fnl/plugin/editing.fnl
vim.pack.add({"https://github.com/windwp/nvim-autopairs", "https://github.com/kylechui/nvim-surround"})
local _let_1_ = require("nfnl.module")
local autoload = _let_1_.autoload
local autopairs = autoload("nvim-autopairs")
local opts = {enable_check_bracket_line = false}
return autopairs.setup(opts)
