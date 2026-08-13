-- [nfnl] fnl/init.fnl
vim.pack.add({"https://github.com/rfmejia/nfnl"})
local _let_1_ = require("nfnl.module")
local autoload = _let_1_.autoload
local util = autoload("juice.util")
return util["call-setup"]({"juice.options", "juice.colors", "juice.filetypes", "juice.commands", "juice.autocmds", "juice.mappings", "juice.lsp", "juice.dotenvrc"})
