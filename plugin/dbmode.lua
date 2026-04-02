-- [nfnl] fnl/plugin/dbmode.fnl
vim.pack.add({"https://github.com/tpope/vim-dadbod", "https://github.com/kristijanhusak/vim-dadbod-completion"})
local _let_1_ = require("nfnl.module")
local autoload = _let_1_.autoload
local util = autoload("juice.util")
local dadbod_maps = {{"n", "<localleader>d;", ":DB g:db ", {desc = "[dadbod] run an sql statement in command mode", noremap = true, buffer = true}}, {"n", "<localleader>dd", ":.DB g:db<cr>", {desc = "[dadbod] run line as an sql statement", noremap = true, buffer = true}}, {"n", "<localleader>dp", "vip:DB g:db<cr>", {desc = "[dadbod] run paragraph as an sql statement", noremap = true, buffer = true}}, {"n", "<localleader>db", ":%DB g:db<cr>", {desc = "[dadbod] run buffer as sql statements", noremap = true, buffer = true}}}
local configure
local function _2_()
  util["set-keys"](dadbod_maps)
  vim.opt_local.omnifunc = "vim_dadbod_completion#omni"
  if vim.env.DADBOD_DEFAULT_DB then
    return vim.cmd.DB(("g:db = " .. vim.env.DADBOD_DEFAULT_DB))
  else
    return nil
  end
end
configure = _2_
configure()
return vim.api.nvim_create_autocmd("FileType", {pattern = {"sql", "mysql", "pgsql"}, callback = configure})
