-- [nfnl] Compiled from fnl/juice/tmux-nav.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
local util = autoload("juice.util")
local directions = {up = {"k", "-U"}, down = {"j", "-D"}, left = {"h", "-L"}, right = {"l", "-R"}}
local function vim_direction(direction)
  _G.assert((nil ~= direction), "Missing argument direction on /home/rfmejia/.config/nvim/fnl/juice/tmux-nav.fnl:6")
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
  _G.assert((nil ~= direction), "Missing argument direction on /home/rfmejia/.config/nvim/fnl/juice/tmux-nav.fnl:7")
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
  _G.assert((nil ~= direction), "Missing argument direction on /home/rfmejia/.config/nvim/fnl/juice/tmux-nav.fnl:9")
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
  _G.assert((nil ~= direction), "Missing argument direction on /home/rfmejia/.config/nvim/fnl/juice/tmux-nav.fnl:18")
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
  _G.assert((nil ~= direction), "Missing argument direction on /home/rfmejia/.config/nvim/fnl/juice/tmux-nav.fnl:26")
  local current_vim_win = vim.fn.winnr()
  vim_navigate(direction)
  if (current_vim_win == vim.fn.winnr()) then
    return tmux_navigate(direction)
  else
    return nil
  end
end
local function setup_default_mapping(in_tmux_3f)
  _G.assert((nil ~= in_tmux_3f), "Missing argument in-tmux? on /home/rfmejia/.config/nvim/fnl/juice/tmux-nav.fnl:32")
  local nav_keys = {left = "<M-h>", right = "<M-l>", up = "<M-k>", down = "<M-j>"}
  local options = {left = {desc = "jump to the left window", noremap = true, silent = true}, right = {desc = "jump to the right window", noremap = true, silent = true}, up = {desc = "jump to the window above", noremap = true, silent = true}, down = {desc = "jump to the window below", noremap = true, silent = true}}
  local vim_keys = {left = "<C-w>h", right = "<C-w>l", up = "<C-w>k", down = "<C-w>l"}
  local tmux_keys
  local function _18_()
    return navigate("left")
  end
  local function _19_()
    return navigate("right")
  end
  local function _20_()
    return navigate("up")
  end
  local function _21_()
    return navigate("down")
  end
  tmux_keys = {left = _18_, right = _19_, up = _20_, down = _21_}
  local win_nav
  if in_tmux_3f then
    win_nav = tmux_keys
  else
    win_nav = vim_keys
  end
  local make_mapping
  local function _23_(dir)
    _G.assert((nil ~= dir), "Missing argument dir on /home/rfmejia/.config/nvim/fnl/juice/tmux-nav.fnl:52")
    local mapping
    local function _24_(_241)
      return core.get(_241, dir)
    end
    mapping = core.map(_24_, {nav_keys, win_nav, options})
    table.insert(mapping, 1, "n")
    return mapping
  end
  make_mapping = _23_
  local mappings = core.map(make_mapping, {"left", "right", "up", "down"})
  return util["set-keys"](mappings)
end
local function setup()
  return setup_default_mapping(vim.env.TMUX)
end
return {setup = setup}
