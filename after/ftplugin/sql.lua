-- [nfnl] Compiled from fnl/after/ftplugin/sql.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local util = autoload("juice.util")
return util["set-keys"]({{"n", "<localleader>du", ":DBUIToggle<cr>", {desc = "toggle dadbod ui", noremap = true, buffer = vim.api.nvim_get_current_buf()}}, {"n", "<localleader>d;", ":DB g:db ", {desc = "run an sql statement in command mode", noremap = true, buffer = vim.api.nvim_get_current_buf()}}, {"n", "<localleader>dd", ":.DB g:db<cr>", {desc = "run line as an sql statement", noremap = true, buffer = vim.api.nvim_get_current_buf()}}, {"n", "<localleader>dp", "vip:DB g:db<cr>", {desc = "run paragraph as an sql statement", noremap = true, buffer = vim.api.nvim_get_current_buf()}}, {"n", "<localleader>db", ":%DB g:db<cr>", {desc = "run buffer as sql statements", noremap = true, buffer = vim.api.nvim_get_current_buf()}}})
