-- [nfnl] fnl/after/ftplugin/fennel.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local notify = autoload("nfnl.notify")
local core = autoload("nfnl.core")
local util = autoload("juice.util")
core["merge!"](vim.opt_local, {shiftwidth = 4, tabstop = 2, expandtab = true, textwidth = 80, commentstring = ";; %s"})
local function buffer_is_modified(buf_num)
  if (nil == buf_num) then
    _G.error("Missing argument buf-num on /home/rfmejia/.config/nvim/fnl/after/ftplugin/fennel.fnl:12", 2)
  else
  end
  return vim.api.nvim_get_option_value("modified", {buf = buf_num})
end
local function format_fennel(path)
  if (nil == path) then
    _G.error("Missing argument path on /home/rfmejia/.config/nvim/fnl/after/ftplugin/fennel.fnl:15", 2)
  else
  end
  if buffer_is_modified(vim.api.nvim_get_current_buf()) then
    return notify.error("fnlfmt: cannot format a modified buffer")
  else
    local case_4_, case_5_ = vim.fn.system({"fnlfmt", "--fix", path})
    if true then
      local _ = case_4_
      return vim.cmd("e!")
    elseif ((case_4_ == nil) and (nil ~= case_5_)) then
      local err_msg = case_5_
      return notify.error("[fennel] Could not run `fnlfmt`: ", err_msg)
    else
      return nil
    end
  end
end
local function _8_()
  return format_fennel(vim.fn.expand("%:p"))
end
vim.keymap.set("n", "grf", _8_, {desc = "[fennel] (c)ode (f)ormat", buffer = true})
local function _9_()
  return format_fennel(vim.fn.expand("%:p"))
end
vim.api.nvim_buf_create_user_command(0, "FnlFmt", _9_, {bang = true})
local function _10_()
  return format_fennel(vim.fn.expand("%:p"))
end
vim.api.nvim_create_autocmd("BufWritePost", {callback = _10_, buffer = vim.api.nvim_get_current_buf(), desc = "format on buffer write", group = vim.api.nvim_create_augroup("format_group", {clear = true})})
return vim.lsp.enable("fennel_ls")
