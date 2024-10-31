-- [nfnl] Compiled from fnl/init.fnl by https://github.com/Olical/nfnl, do not edit.
require("juice.bootstrap").setup()
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local util = autoload("juice.util")
return util["auto-setup"]("juice.options", "juice.colorscheme", "juice.plugins", "juice.mappings", "git-info", "journal-tools", "tmux-nav", "trim-whitespace")
