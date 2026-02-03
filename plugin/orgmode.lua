-- [nfnl] fnl/plugin/orgmode.fnl
local _let_1_ = require("nfnl.module")
local autoload = _let_1_.autoload
local pacman = autoload("pacman")
local util = autoload("juice.util")
local pack = "https://github.com/nvim-orgmode/orgmode"
local org_home = (vim.env.JOURNAL or "~/journal")
local opts = {org_agenda_files = (org_home .. "/**/*"), org_default_notes_file = (org_home .. "/refile.org"), org_capture_templates = {b = {description = "Bookmark", template = "- %<%H:%M> [%a]\n%?\n", headline = "notes", datetree = {tree_type = "day", reversed = true}}, c = {description = "Clip register", template = "- %<%H:%M> [%a]\n%?\n%x\n", headline = "notes", datetree = {tree_type = "day", reversed = true}}, n = {description = "Take note", template = "- %<%H:%M> %? \n", headline = "notes", datetree = {tree_type = "day", reversed = true}}, t = {description = "Add task - unfiled", template = "* TODO  %?\n  %U\n", headline = "unfiled"}, ["2"] = {description = "Add task - < 20 min", template = "* TODO  %?\n  %U\n", headline = "quick"}}}
pacman.add(pack)
pacman["load-now"]("orgmode")
return util.call("orgmode", "setup", opts)
