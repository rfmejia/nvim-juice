-- [nfnl] Compiled from fnl/after/ftplugin/fennel.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = autoload("nfnl.string")
local blank_3f = _local_2_["blank?"]
local _local_3_ = autoload("juice.util")
local nmap = _local_3_["nmap"]
local set_opts = _local_3_["set-opts"]
set_opts({shiftwidth = 2, tabstop = 2, expandtab = true, textwidth = 100})
local function format_fennel(path)
  local filename
  if blank_3f(path) then
    filename = vim.fn.expand("%:p")
  else
    filename = path
  end
  local fnlfmt_cmd = {"fnlfmt", "--fix", filename}
  local _5_, _6_ = vim.fn.system(fnlfmt_cmd)
  if (nil ~= _5_) then
    local ok = _5_
    return vim.cmd("e!")
  elseif ((_5_ == nil) and (nil ~= _6_)) then
    local err_msg = _6_
    return print("Could not run `fnlfmt`: ", err_msg)
  else
    return nil
  end
end
local function _8_()
  return format_fennel(vim.fn.expand("%:p"))
end
return nmap("<localleader>cf", _8_, {"buffer"})
