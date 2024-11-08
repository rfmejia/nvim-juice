-- [nfnl] Compiled from fnl/init.fnl by https://github.com/Olical/nfnl, do not edit.
require("juice.bootstrap").setup()
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local mappings = autoload("juice.mappings")
local util = autoload("juice.util")
util["auto-setup"]("juice.options", "juice.colorscheme", "juice.plugins", "juice.mappings", "git-info", "tmux-nav", "trim-whitespace")
local journal_tools = autoload("journal-tools")
return journal_tools.setup({maps = mappings["journal-maps"]})
