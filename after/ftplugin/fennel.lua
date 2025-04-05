-- [nfnl] Compiled from fnl/after/ftplugin/fennel.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local notify = autoload("nfnl.notify")
local util = autoload("juice.util")
util["assoc-in"](vim.opt_local, {shiftwidth = 4, tabstop = 2, expandtab = true, textwidth = 100, commentstring = ";; %s"})
local function buffer_is_modified(buf_num)
  _G.assert((nil ~= buf_num), "Missing argument buf-num on /home/rfmejia/.config/nvim/fnl/after/ftplugin/fennel.fnl:12")
  return vim.api.nvim_buf_get_option(buf_num, "modified")
end
local function format_fennel(path)
  _G.assert((nil ~= path), "Missing argument path on /home/rfmejia/.config/nvim/fnl/after/ftplugin/fennel.fnl:15")
  if buffer_is_modified(vim.api.nvim_get_current_buf()) then
    return notify.error("fnlfmt: cannot format a modified buffer")
  else
    local _2_, _3_ = vim.fn.system({"fnlfmt", "--fix", path})
    if true then
      local _ = _2_
      return vim.cmd("e!")
    elseif ((_2_ == nil) and (nil ~= _3_)) then
      local err_msg = _3_
      return notify.error("[fennel] Could not run `fnlfmt`: ", err_msg)
    else
      return nil
    end
  end
end
local function _6_()
  return format_fennel(vim.fn.expand("%:p"))
end
vim.keymap.set("n", "grf", _6_, {desc = "[fennel] (c)ode (f)ormat", buffer = true})
local function _7_()
  return format_fennel(vim.fn.expand("%:p"))
end
vim.api.nvim_buf_create_user_command(0, "FnlFmt", _7_, {bang = true})
local function _8_()
  return format_fennel(vim.fn.expand("%:p"))
end
vim.api.nvim_create_autocmd("BufWritePost", {callback = _8_, buffer = vim.api.nvim_get_current_buf(), desc = "format on buffer write", group = vim.api.nvim_create_augroup("format_group", {clear = true})})
local lspconfig = autoload("lspconfig")
return lspconfig.fennel_ls.setup({})
