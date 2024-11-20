-- [nfnl] Compiled from fnl/init.fnl by https://github.com/Olical/nfnl, do not edit.
require("juice.bootstrap").setup()
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local mappings = autoload("juice.mappings")
local util = autoload("juice.util")
util["call-setup"]("juice.options", "juice.colorscheme", "juice.plugins", "juice.mappings", "git-info", "tmux-nav", "trim-whitespace", "wildignore")
local journal_tools = autoload("journal-tools")
local opts = {maps = mappings["journal-maps"]}
local function _2_()
  return journal_tools.setup(opts)
end
return vim.api.nvim_create_user_command("JournalInit", _2_, {desc = "Load default mappings for journal tools"})
