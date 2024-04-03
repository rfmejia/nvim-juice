-- [nfnl] Compiled from fnl/juice/filetypes/fennel.fnl by https://github.com/Olical/nfnl, do not edit.
local s = require("nfnl.string")
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
local function _2_()
  return format_fennel(vim.fn.expand("%:p"))
end
return vim.api.nvim_set_keymap("n", "<localleader>cf", "", {callback = _2_})
