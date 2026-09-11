-- [nfnl] fnl/init.fnl
vim.pack.add({"https://github.com/rfmejia/nfnl"})
--[[ "nfnl.module.autoload loads a module at the first callsite, not upon
         require - this should decrease startup time" ]]
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local util = autoload("juice.util")
return util["call-setup"]({"juice.options", "juice.colors", "juice.filetypes", "juice.commands", "juice.autocmds", "juice.mappings", "juice.lsp", "juice.dotenvrc"})
