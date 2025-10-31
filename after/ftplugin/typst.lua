-- [nfnl] fnl/after/ftplugin/typst.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local core = autoload("nfnl.core")
return core["merge!"](vim.opt_local, {shiftwidth = 2, tabstop = 2, textwidth = 0, wrap = true, spell = true, spelllang = "en_us"})
