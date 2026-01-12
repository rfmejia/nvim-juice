-- [nfnl] fnl/plugin/orgmode.fnl
local _let_1_ = require("nfnl.module")
local autoload = _let_1_.autoload
local pacman = autoload("pacman")
local pack = "https://github.com/nvim-orgmode/orgmode"
local util = autoload("juice.util")
local opts = {org_agenda_files = "~/orgfiles/**/*", org_default_notes_file = "~/orgfiles/refile.org"}
local keymaps = {{"n", "goa", ":Org agenda<CR>", {desc = "[orgmode] start agenda"}}, {"n", "goc", ":Org capture<CR>", {desc = "[orgmode] start capture"}}}
pacman.add(pack)
local function _2_()
  util.call("orgmode", "setup", opts)
  return util["set-keys"](keymaps)
end
return pacman["load-on-keymap"]("orgmode", {"goa", "goc"}, _2_)
