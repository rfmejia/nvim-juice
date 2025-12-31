-- [nfnl] fnl/plugin/sql.fnl
local _let_1_ = require("nfnl.module")
local autoload = _let_1_.autoload
local pacman = autoload("pacman")
local packs = {"https://github.com/tpope/vim-dadbod", "https://github.com/kristijanhusak/vim-dadbod-completion"}
local dadbod_maps = {{"n", "<localleader>d;", ":DB g:db ", {desc = "[dadbod] run an sql statement in command mode", noremap = true, buffer = true}}, {"n", "<localleader>dd", ":.DB g:db<cr>", {desc = "[dadbod] run line as an sql statement", noremap = true, buffer = true}}, {"n", "<localleader>dp", "vip:DB g:db<cr>", {desc = "[dadbod] run paragraph as an sql statement", noremap = true, buffer = true}}, {"n", "<localleader>db", ":%DB g:db<cr>", {desc = "[dadbod] run buffer as sql statements", noremap = true, buffer = true}}}
pacman.add(packs)
local function _2_()
  local util = autoload("juice.util")
  return util["set-keys"](dadbod_maps)
end
return pacman["load-on-event"]({"vim-dadbod", "vim-dadbod-completion"}, "FileType", {pattern = {"sql", "mysql", "pgsql"}, callback = _2_})
