-- [nfnl] fnl/plugin/dbmode.fnl
local function setup(keymaps, default_db)
  local _let_1_ = require("nfnl.module")
  local autoload = _let_1_.autoload
  local util = autoload("juice.util")
  util["set-keys"](keymaps)
  vim.opt_local.omnifunc = "vim_dadbod_completion#omni"
  if default_db then
    return vim.cmd.DB(("g:db = " .. default_db))
  else
    return nil
  end
end
local _let_3_ = require("nfnl.module")
local autoload = _let_3_.autoload
local pacman = autoload("pacman")
local packs = {"https://github.com/tpope/vim-dadbod", "https://github.com/kristijanhusak/vim-dadbod-completion"}
local dadbod_maps = {{"n", "<localleader>d;", ":DB g:db ", {desc = "[dadbod] run an sql statement in command mode", noremap = true, buffer = true}}, {"n", "<localleader>dd", ":.DB g:db<cr>", {desc = "[dadbod] run line as an sql statement", noremap = true, buffer = true}}, {"n", "<localleader>dp", "vip:DB g:db<cr>", {desc = "[dadbod] run paragraph as an sql statement", noremap = true, buffer = true}}, {"n", "<localleader>db", ":%DB g:db<cr>", {desc = "[dadbod] run buffer as sql statements", noremap = true, buffer = true}}}
pacman.add(packs)
local function _4_()
  setup(dadbod_maps, vim.env.DADBOD_DEFAULT_DB)
  local function _5_()
    return setup(dadbod_maps, vim.env.DADBOD_DEFAULT_DB)
  end
  return vim.api.nvim_create_autocmd("FileType", {pattern = {"sql", "mysql", "pgsql"}, callback = _5_})
end
return pacman["load-on-event"]({"vim-dadbod", "vim-dadbod-completion"}, "FileType", {pattern = {"sql", "mysql", "pgsql"}, callback = _4_})
