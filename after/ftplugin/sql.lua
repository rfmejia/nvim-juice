-- [nfnl] Compiled from fnl/after/ftplugin/sql.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = autoload("juice.util")
local nmap = _local_2_["nmap"]
nmap("<localleader>du", ":DBUIToggle<cr>", {"noremap", "buffer"})
nmap("<localleader>d;", ":DB g:db ", {"noremap", "buffer"})
nmap("<localleader>dd", ":.DB g:db<cr>", {"noremap", "buffer"})
nmap("<localleader>db", ":%DB g:db<cr>", {"noremap", "buffer"})
return nmap("<localleader>dp", "vip:DB g:db<cr>", {"noremap", "buffer"})
