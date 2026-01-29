-- [nfnl] fnl/plugin/orgmode.fnl
local _let_1_ = require("nfnl.module")
local autoload = _let_1_.autoload
local pacman = autoload("pacman")
local pack = "https://github.com/nvim-orgmode/orgmode"
local util = autoload("juice.util")
local org_home = (vim.env.ORG_HOME or "~/orgfiles")
local opts = {org_agenda_files = (org_home .. "/**/*"), org_default_notes_file = (org_home .. "/_main.org"), org_capture_templates = {c = {description = "Clip register", template = "-  %?\n%x\n", target = (org_home .. "/_clips.org")}, m = {description = "Add myshake task", template = "* TODO  %?\n  %u\n", headline = "myshake"}, ["2"] = {description = "< 20 min task", template = "* TODO  %?\n  %u", headline = "quick"}}}
local keymaps = {{"n", "goa", ":Org agenda<CR>", {desc = "[orgmode] start agenda"}}, {"n", "goc", ":Org capture<CR>", {desc = "[orgmode] start capture"}}}
pacman.add(pack)
local function _2_()
  util.call("orgmode", "setup", opts)
  return util["set-keys"](keymaps)
end
return pacman["load-on-keymap"]("orgmode", {"goa", "goc"}, _2_)
