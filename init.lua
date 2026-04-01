-- [nfnl] fnl/init.fnl
vim.pack.add({"https://github.com/rfmejia/nfnl"})
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local util = autoload("juice.util")
util["call-setup"]({"juice.options", "juice.filetypes", "juice.commands", "juice.autocmds", "juice.mappings", "juice.lsp", "juice.dotenvrc"})
return vim.cmd.colorscheme("default-black")
