-- [nfnl] Compiled from fnl/juice/tmux/init.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = autoload("juice.util")
local nmap = _local_2_["nmap"]
local directions = {up = {"k", "-U"}, down = {"j", "-D"}, left = {"h", "-L"}, right = {"l", "-R"}}
local function vim_direction(direction)
  _G.assert((nil ~= direction), "Missing argument direction on /home/rfmejia/.config/nvim/fnl/juice/tmux/init.fnl:5")
  local t_3_ = directions
  if (nil ~= t_3_) then
    t_3_ = (t_3_)[direction]
  else
  end
  if (nil ~= t_3_) then
    t_3_ = (t_3_)[1]
  else
  end
  return t_3_
end
local function tmux_direction(direction)
  _G.assert((nil ~= direction), "Missing argument direction on /home/rfmejia/.config/nvim/fnl/juice/tmux/init.fnl:6")
  local t_6_ = directions
  if (nil ~= t_6_) then
    t_6_ = (t_6_)[direction]
  else
  end
  if (nil ~= t_6_) then
    t_6_ = (t_6_)[2]
  else
  end
  return t_6_
end
local function vim_navigate(direction)
  _G.assert((nil ~= direction), "Missing argument direction on /home/rfmejia/.config/nvim/fnl/juice/tmux/init.fnl:8")
  return vim.cmd(("wincmd" .. " " .. vim_direction(direction)))
end
local function get_tmux_socket()
  local _9_ = vim.env.TMUX
  if (nil ~= _9_) then
    local _10_ = vim.fn.split(_9_, ",")
    if (nil ~= _10_) then
      local t_11_ = _10_
      if (nil ~= t_11_) then
        t_11_ = (t_11_)[1]
      else
      end
      return t_11_
    else
      return _10_
    end
  else
    return _9_
  end
end
local function tmux_navigate(direction)
  _G.assert((nil ~= direction), "Missing argument direction on /home/rfmejia/.config/nvim/fnl/juice/tmux/init.fnl:17")
  local socket = get_tmux_socket()
  local pane = tmux_direction(direction)
  local tmux_cmd = {"tmux", "-S", socket, "select-pane", pane}
  local _15_, _16_ = vim.fn.system(tmux_cmd)
  if (nil ~= _15_) then
    local ok = _15_
    return nil
  elseif ((_15_ == nil) and (nil ~= _16_)) then
    local err_msg = _16_
    return print("Could not run `tmux`: ", err_msg)
  else
    return nil
  end
end
local function navigate(direction)
  _G.assert((nil ~= direction), "Missing argument direction on /home/rfmejia/.config/nvim/fnl/juice/tmux/init.fnl:25")
  local current_vim_win = vim.fn.winnr()
  vim_navigate(direction)
  if (current_vim_win == vim.fn.winnr()) then
    return tmux_navigate(direction)
  else
    return nil
  end
end
local function _19_()
  return navigate("up")
end
local function _20_()
  return navigate("down")
end
local function _21_()
  return navigate("left")
end
local function _22_()
  return navigate("right")
end
return {navigate = navigate, ["navigate-up"] = _19_, ["navigate-down"] = _20_, ["navigate-left"] = _21_, ["navigate-right"] = _22_}
