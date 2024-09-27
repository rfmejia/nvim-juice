-- [nfnl] Compiled from fnl/after/ftplugin/bash.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local util = autoload("juice.util")
return util["assoc-in"](vim.opt, {makeprg = "sh %", signcolumn = "no", textwidth = 80})
