-- [nfnl] fnl/plugin/orgmode.fnl
local _let_1_ = require("nfnl.module")
local autoload = _let_1_.autoload
local pacman = autoload("pacman")
local util = autoload("juice.util")
local pack = "https://github.com/nvim-orgmode/orgmode"
local org_home = (vim.env.JOURNAL or "~/journal")
local opts = {org_agenda_files = (org_home .. "/**/*"), org_default_notes_file = (org_home .. "/journal.org"), org_capture_templates = {b = {description = "Bookmark", template = "* %? [%a]\n", target = (org_home .. "/bookmarks.org")}, c = {description = "Clip register", template = "* %? \n%x\n", target = (org_home .. "/clips.org")}, t = {description = "Add task - unfiled", template = "* TODO  %?\n  %U\n", headline = "unfiled"}, m = {description = "Add task - myshake", template = "* TODO  %?\n  %U %a\n", headline = "myshake"}, ["2"] = {description = "Add task - < 20 min", template = "* TODO  %?\n  %U\n", headline = "quick"}}}
pacman.add(pack)
pacman["load-now"]("orgmode")
return util.call("orgmode", "setup", opts)
