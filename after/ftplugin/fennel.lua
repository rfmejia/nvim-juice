-- [nfnl] Compiled from fnl/after/ftplugin/fennel.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local s = autoload("nfnl.string")
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.textwidth = 100
local function format_fennel(path)
  local filename
  if s["blank?"](path) then
    filename = vim.fn.expand("%:p")
  else
    filename = path
  end
  return vim.fn.system({"fnlfmt", "--fix", filename})
end
local function _3_()
  return format_fennel(vim.fn.expand("%:p"))
end
return vim.api.nvim_set_keymap("n", "<localleader>cf", "", {callback = _3_})
