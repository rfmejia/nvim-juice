-- [nfnl] fnl/plugin/orgmode.fnl
local _let_1_ = require("nfnl.module")
local autoload = _let_1_.autoload
local pacman = autoload("pacman")
local pack = "https://github.com/nvim-orgmode/orgmode"
local util = autoload("juice.util")
local org_home = (vim.env.JOURNAL or "~/journal")
local opts = {org_agenda_files = (org_home .. "/**/*"), org_default_notes_file = (org_home .. "/journal.org"), org_capture_templates = {b = {description = "Bookmark", template = "- %? [%a]\n", target = (org_home .. "/bookmarks.org")}, c = {description = "Clip register", template = "- %? \n%x\n", target = (org_home .. "/clips.org")}, t = {description = "Add task", template = "* TODO  %?\n  %U\n", headline = "unfiled"}, m = {description = "Add task - myshake", template = "* TODO  %?\n  %U\n", headline = "myshake"}, ["2"] = {description = "Add task - quick (< 20 min)", template = "* TODO  %?\n  %U\n", headline = "quick"}}, mappings = {global = {}}}
pacman.add(pack)
local function _2_()
  util.call("orgmode", "setup", opts)
  return vim.lsp.enable("org")
end
return pacman["load-on-keymap"]("orgmode", "<leader>o", _2_)
