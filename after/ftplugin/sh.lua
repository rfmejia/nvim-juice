-- [nfnl] Compiled from fnl/after/ftplugin/sh.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
return core["merge!"](vim.opt_local, {makeprg = "sh %", signcolumn = "no", textwidth = 80})
