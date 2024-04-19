-- [nfnl] Compiled from fnl/after/ftplugin/fennel.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = autoload("nfnl.string")
local blank_3f = _local_2_["blank?"]
local _local_3_ = autoload("juice.util")
local nmap = _local_3_["nmap"]
local set_opts = _local_3_["set-opts"]
set_opts({shiftwidth = 2, tabstop = 2, expandtab = true, textwidth = 100})
local function buffer_is_modified(buf_num)
  _G.assert((nil ~= buf_num), "Missing argument buf-num on /home/rfmejia/.config/nvim/fnl/after/ftplugin/fennel.fnl:7")
  return vim.api.nvim_buf_get_option(buf_num, "modified")
end
local function format_fennel(path)
  _G.assert((nil ~= path), "Missing argument path on /home/rfmejia/.config/nvim/fnl/after/ftplugin/fennel.fnl:10")
  local modified = buffer_is_modified(vim.api.nvim_get_current_buf())
  local fnlfmt_cmd = {"fnlfmt", "--fix", path}
  if not modified then
    local _4_, _5_ = vim.fn.system(fnlfmt_cmd)
    if (nil ~= _4_) then
      local ok = _4_
      return vim.cmd("e!")
    elseif ((_4_ == nil) and (nil ~= _5_)) then
      local err_msg = _5_
      return print("Could not run `fnlfmt`: ", err_msg)
    else
      return nil
    end
  else
    return error("fnlfmt: cannot format a modified buffer")
  end
end
local function _8_()
  return format_fennel(vim.fn.expand("%:p"))
end
return nmap("<localleader>cf", _8_, {"buffer"})
