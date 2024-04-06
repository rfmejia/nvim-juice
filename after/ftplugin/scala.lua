-- [nfnl] Compiled from after/ftplugin/scala.fnl by https://github.com/Olical/nfnl, do not edit.
local u = require("util")
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.textwidth = 100
vim.opt.signcolumn = "yes:1"
do end (vim.opt.indentkeys):remove("<>>")
local function run_scalafmt(path)
  local s = require("nfnl.string")
  local filename
  if s["blank?"](path) then
    filename = vim.fn.expand("%:p")
  else
    filename = path
  end
  return vim.fn.system({"scalafmt", "--mode", "changed", "--config", ".scalafmt.conf", filename, filename})
end
local function _2_()
  return run_scalafmt()
end
vim.api.nvim_create_user_command("ScalafmtApply", _2_, {bang = true})
local function _3_()
  return run_scalafmt(vim.fn.expand("%:p"))
end
u.nmap("<localleader>cf", _3_, {"noremap", "nowait", "silent"})
return u.nmap("<localleader>s", "vip:sort<cr>", {"noremap", "nowait", "silent"})
