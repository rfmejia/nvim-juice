-- [nfnl] Compiled from fnl/after/ftplugin/mail.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local util = autoload("juice.util")
return util["assoc-in"](vim.opt, {shiftwidth = 2, tabstop = 2, textwidth = 80, wrap = true, spell = true, spelllang = "en_us"})
