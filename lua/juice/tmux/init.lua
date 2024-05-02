-- [nfnl] Compiled from fnl/juice/tmux/init.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local directions = {up = {"k", "-U"}, down = {"j", "-D"}, left = {"h", "-L"}, right = {"l", "-R"}}
local function vim_direction(direction)
  _G.assert((nil ~= direction), "Missing argument direction on /home/rfmejia/.config/nvim/fnl/juice/tmux/init.fnl:4")
  local t_2_ = directions
  if (nil ~= t_2_) then
    t_2_ = (t_2_)[direction]
  else
  end
  if (nil ~= t_2_) then
    t_2_ = (t_2_)[1]
  else
  end
  return t_2_
end
local function tmux_direction(direction)
  _G.assert((nil ~= direction), "Missing argument direction on /home/rfmejia/.config/nvim/fnl/juice/tmux/init.fnl:5")
  local t_5_ = directions
  if (nil ~= t_5_) then
    t_5_ = (t_5_)[direction]
  else
  end
  if (nil ~= t_5_) then
    t_5_ = (t_5_)[2]
  else
  end
  return t_5_
end
local function vim_navigate(direction)
  _G.assert((nil ~= direction), "Missing argument direction on /home/rfmejia/.config/nvim/fnl/juice/tmux/init.fnl:7")
  return vim.cmd(("wincmd" .. " " .. vim_direction(direction)))
end
local function get_tmux_socket()
  local _8_ = vim.env.TMUX
  if (nil ~= _8_) then
    local _9_ = vim.fn.split(_8_, ",")
    if (nil ~= _9_) then
      local t_10_ = _9_
      if (nil ~= t_10_) then
        t_10_ = (t_10_)[1]
      else
      end
      return t_10_
    else
      return _9_
    end
  else
    return _8_
  end
end
local function tmux_navigate(direction)
  _G.assert((nil ~= direction), "Missing argument direction on /home/rfmejia/.config/nvim/fnl/juice/tmux/init.fnl:16")
  local socket = get_tmux_socket()
  local pane = tmux_direction(direction)
  local tmux_cmd = {"tmux", "-S", socket, "select-pane", pane}
  local _14_, _15_ = vim.fn.system(tmux_cmd)
  if (nil ~= _14_) then
    local ok = _14_
    return nil
  elseif ((_14_ == nil) and (nil ~= _15_)) then
    local err_msg = _15_
    return print("Could not run `tmux`: ", err_msg)
  else
    return nil
  end
end
local function navigate(direction)
  _G.assert((nil ~= direction), "Missing argument direction on /home/rfmejia/.config/nvim/fnl/juice/tmux/init.fnl:24")
  local current_vim_win = vim.fn.winnr()
  vim_navigate(direction)
  if (current_vim_win == vim.fn.winnr()) then
    return tmux_navigate(direction)
  else
    return nil
  end
end
local function _18_()
  return navigate("up")
end
local function _19_()
  return navigate("down")
end
local function _20_()
  return navigate("left")
end
local function _21_()
  return navigate("right")
end
return {navigate = navigate, ["navigate-up"] = _18_, ["navigate-down"] = _19_, ["navigate-left"] = _20_, ["navigate-right"] = _21_}
