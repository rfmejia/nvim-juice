-- [nfnl] fnl/init.fnl
require("juice.bootstrap").setup()
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local util = autoload("juice.util")
return util["call-setup"]("juice.options", "juice.colorscheme", "juice.plugins", "juice.mappings", "juice.commands", "juice.lsp", "juice.dotenvrc", "journal-tools", "git-info", "tmux-nav", "trim-whitespace", "wildgitignore")
