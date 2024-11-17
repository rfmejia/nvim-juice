-- [nfnl] Compiled from fnl/init.fnl by https://github.com/Olical/nfnl, do not edit.
require("juice.bootstrap").setup()
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local mappings = autoload("juice.mappings")
local util = autoload("juice.util")
util["call-setup"]("juice.options", "juice.colorscheme", "juice.plugins", "juice.mappings", "git-info", "tmux-nav", "trim-whitespace")
do
  local journal_tools = autoload("journal-tools")
  journal_tools.setup({maps = mappings["journal-maps"]})
end
vim.opt.path:append("**")
return vim.keymap.set("n", "<leader>f", ":find<space>", {desc = "pre-fill find command"})
