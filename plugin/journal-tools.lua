-- [nfnl] fnl/plugin/journal-tools.fnl
local function bind_journal_maps(journal_tools)
  return {{"n", "<localleader>w", journal_tools["insert-week"], {desc = "[journal] insert current week as an h2 header", buffer = true, silent = true}}, {"n", "<localleader>d", journal_tools["insert-day"], {desc = "[journal] insert current date as an h3 header", buffer = true, silent = true}}, {"n", "<localleader>t", journal_tools["insert-time"], {desc = "[journal] insert current time as an h4 header", buffer = true, silent = true}}, {"n", "<localleader>x", journal_tools["insert-task"], {desc = "[journal] insert current time as an h4 header", buffer = true, silent = true}}}
end
local function init_plugin()
  vim.cmd.packadd("journal-tools")
  local _let_1_ = require("nfnl.module")
  local autoload = _let_1_.autoload
  local journal_tools = autoload("journal-tools")
  local keymaps = bind_journal_maps(journal_tools)
  journal_tools["register-tools"]({maps = keymaps})
  return vim.notify("[journal-tools] Loaded tools")
end
local function _2_()
  vim.api.nvim_del_user_command("JournalInit")
  return init_plugin()
end
return vim.api.nvim_create_user_command("JournalInit", _2_, {desc = "Load default mappings for journal tools"})
