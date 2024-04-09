-- [nfnl] Compiled from fnl/after/ftplugin/bash.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = autoload("juice.util")
local set_opts = _local_2_["set-opts"]
return set_opts({makeprg = "sh %", signcolumn = "no", textwidth = 80})
