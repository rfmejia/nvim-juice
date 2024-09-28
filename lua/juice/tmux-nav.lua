-- [nfnl] Compiled from fnl/juice/tmux-nav.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
local notify = autoload("nfnl.notify")
local util = autoload("juice.util")
local directions = {up = {"k", "-U"}, down = {"j", "-D"}, left = {"h", "-L"}, right = {"l", "-R"}}
local function vim_direction(direction)
  _G.assert((nil ~= direction), "Missing argument direction on /home/rfmejia/.config/nvim/fnl/juice/tmux-nav.fnl:7")
  local t_2_ = directions
  if (nil ~= t_2_) then
    t_2_ = t_2_[direction]
  else
  end
  if (nil ~= t_2_) then
    t_2_ = t_2_[1]
  else
  end
  return t_2_
end
local function tmux_direction(direction)
  _G.assert((nil ~= direction), "Missing argument direction on /home/rfmejia/.config/nvim/fnl/juice/tmux-nav.fnl:8")
  local t_5_ = directions
  if (nil ~= t_5_) then
    t_5_ = t_5_[direction]
  else
  end
  if (nil ~= t_5_) then
    t_5_ = t_5_[2]
  else
  end
  return t_5_
end
local function vim_navigate(direction)
  _G.assert((nil ~= direction), "Missing argument direction on /home/rfmejia/.config/nvim/fnl/juice/tmux-nav.fnl:10")
  return vim.cmd(("wincmd" .. " " .. vim_direction(direction)))
end
local function get_tmux_socket()
  local tmp_3_auto = vim.env.TMUX
  if (nil ~= tmp_3_auto) then
    local tmp_3_auto0 = vim.fn.split(tmp_3_auto, ",")
    if (nil ~= tmp_3_auto0) then
      local t_8_ = tmp_3_auto0
      if (nil ~= t_8_) then
        t_8_ = t_8_[1]
      else
      end
      return t_8_
    else
      return nil
    end
  else
    return nil
  end
end
local function tmux_navigate(direction)
  _G.assert((nil ~= direction), "Missing argument direction on /home/rfmejia/.config/nvim/fnl/juice/tmux-nav.fnl:19")
  local socket = get_tmux_socket()
  local pane = tmux_direction(direction)
  local tmux_cmd = {"tmux", "-S", socket, "select-pane", pane}
  local _12_, _13_ = vim.fn.system(tmux_cmd)
  if (nil ~= _12_) then
    local ok = _12_
    return nil
  elseif ((_12_ == nil) and (nil ~= _13_)) then
    local err_msg = _13_
    return notify.error("Could not run `tmux`: ", err_msg)
  else
    return nil
  end
end
local function navigate(direction)
  _G.assert((nil ~= direction), "Missing argument direction on /home/rfmejia/.config/nvim/fnl/juice/tmux-nav.fnl:27")
  local current_vim_win = vim.fn.winnr()
  vim_navigate(direction)
  if (current_vim_win == vim.fn.winnr()) then
    return tmux_navigate(direction)
  else
    return nil
  end
end
local function setup_default_mapping(in_tmux_3f)
  _G.assert((nil ~= in_tmux_3f), "Missing argument in-tmux? on /home/rfmejia/.config/nvim/fnl/juice/tmux-nav.fnl:33")
  local nav_keys = {left = "<M-h>", right = "<M-l>", up = "<M-k>", down = "<M-j>"}
  local options = {left = {desc = "jump to the left window", noremap = true, silent = true}, right = {desc = "jump to the right window", noremap = true, silent = true}, up = {desc = "jump to the window above", noremap = true, silent = true}, down = {desc = "jump to the window below", noremap = true, silent = true}}
  local vim_keys = {left = "<C-w>h", right = "<C-w>l", up = "<C-w>k", down = "<C-w>l"}
  local tmux_keys
  local function _16_()
    return navigate("left")
  end
  local function _17_()
    return navigate("right")
  end
  local function _18_()
    return navigate("up")
  end
  local function _19_()
    return navigate("down")
  end
  tmux_keys = {left = _16_, right = _17_, up = _18_, down = _19_}
  local win_nav
  if in_tmux_3f then
    win_nav = tmux_keys
  else
    win_nav = vim_keys
  end
  local make_mapping
  local function _21_(dir)
    _G.assert((nil ~= dir), "Missing argument dir on /home/rfmejia/.config/nvim/fnl/juice/tmux-nav.fnl:53")
    local mapping
    local function _22_(_241)
      return core.get(_241, dir)
    end
    mapping = core.map(_22_, {nav_keys, win_nav, options})
    table.insert(mapping, 1, "n")
    return mapping
  end
  make_mapping = _21_
  local mappings = core.map(make_mapping, {"left", "right", "up", "down"})
  return util["set-keys"](mappings)
end
local function setup()
  return setup_default_mapping(vim.env.TMUX)
end
return {setup = setup}
