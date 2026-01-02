-- [nfnl] fnl/after/ftplugin/c.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local core = autoload("nfnl.core")
return core["merge!"](vim.opt_local, {shiftwidth = 4, tabstop = 4, expandtab = true, textwidth = 100})
