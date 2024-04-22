-- [nfnl] Compiled from fnl/after/ftplugin/fennel.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = autoload("juice.util")
local nmap = _local_2_["nmap"]
local set_opts = _local_2_["set-opts"]
set_opts({shiftwidth = 2, tabstop = 2, expandtab = true, textwidth = 100})
local function buffer_is_modified(buf_num)
  _G.assert((nil ~= buf_num), "Missing argument buf-num on /home/rfmejia/.config/nvim/fnl/after/ftplugin/fennel.fnl:6")
  return vim.api.nvim_buf_get_option(buf_num, "modified")
end
local function format_fennel(path)
  _G.assert((nil ~= path), "Missing argument path on /home/rfmejia/.config/nvim/fnl/after/ftplugin/fennel.fnl:9")
  local modified = buffer_is_modified(vim.api.nvim_get_current_buf())
  local fnlfmt_cmd = {"fnlfmt", "--fix", path}
  if not modified then
    local _3_, _4_ = vim.fn.system(fnlfmt_cmd)
    if true then
      local _ = _3_
      return vim.cmd("e!")
    elseif ((_3_ == nil) and (nil ~= _4_)) then
      local err_msg = _4_
      return print("Could not run `fnlfmt`: ", err_msg)
    else
      return nil
    end
  else
    return error("fnlfmt: cannot format a modified buffer")
  end
end
local function _7_()
  return format_fennel(vim.fn.expand("%:p"))
end
nmap("<localleader>cf", _7_, {"buffer"})
local function _8_()
  return format_fennel(vim.fn.expand("%:p"))
end
return vim.api.nvim_buf_create_user_command(0, "FnlFmt", _8_, {bang = true})
