-- [nfnl] Compiled from fnl/after/ftplugin/fennel.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = autoload("nfnl.string")
local blank_3f = _local_2_["blank?"]
local _local_3_ = autoload("juice.util")
local nmap = _local_3_["nmap"]
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.textwidth = 100
local function format_fennel(path)
  local filename
  if blank_3f(path) then
    filename = vim.fn.expand("%:p")
  else
    filename = path
  end
  return vim.fn.system({"fnlfmt", "--fix", filename})
end
local function _5_()
  return format_fennel(vim.fn.expand("%:p"))
end
return nmap("<localleader>cf", _5_)
