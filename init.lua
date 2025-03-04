-- [nfnl] Compiled from fnl/init.fnl by https://github.com/Olical/nfnl, do not edit.
require("juice.bootstrap").setup()
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local util = autoload("juice.util")
util["call-setup"]("juice.options", "juice.colorscheme", "juice.plugins", "juice.mappings", "juice.dotenvrc", "git-info", "tmux-nav", "trim-whitespace", "wildgitignore", "projectify")
local function _2_()
  local mappings = autoload("juice.mappings")
  return util.call("journal-tools", "setup", {maps = mappings["journal-maps"]})
end
return vim.api.nvim_create_user_command("JournalInit", _2_, {desc = "Load default mappings for journal tools"})
