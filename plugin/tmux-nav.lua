-- [nfnl] fnl/plugin/tmux-nav.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local directions = {up = {"k", "-U"}, down = {"j", "-D"}, left = {"h", "-L"}, right = {"l", "-R"}}
local function vim_direction(direction)
  if (nil == direction) then
    _G.error("Missing argument direction on fnl/plugin/tmux-nav.fnl:4", 2)
  else
  end
  local t_3_ = directions
  if (nil ~= t_3_) then
    t_3_ = t_3_[direction]
  else
  end
  if (nil ~= t_3_) then
    t_3_ = t_3_[1]
  else
  end
  return t_3_
end
local function tmux_direction(direction)
  if (nil == direction) then
    _G.error("Missing argument direction on fnl/plugin/tmux-nav.fnl:5", 2)
  else
  end
  local t_7_ = directions
  if (nil ~= t_7_) then
    t_7_ = t_7_[direction]
  else
  end
  if (nil ~= t_7_) then
    t_7_ = t_7_[2]
  else
  end
  return t_7_
end
local function vim_navigate(direction)
  if (nil == direction) then
    _G.error("Missing argument direction on fnl/plugin/tmux-nav.fnl:7", 2)
  else
  end
  return vim.cmd(("wincmd" .. " " .. vim_direction(direction)))
end
local function get_tmux_socket()
  local tmp_3_ = vim.env.TMUX
  if (nil ~= tmp_3_) then
    local tmp_3_0 = vim.fn.split(tmp_3_, ",")
    if (nil ~= tmp_3_0) then
      local t_11_ = tmp_3_0
      if (nil ~= t_11_) then
        t_11_ = t_11_[1]
      else
      end
      return t_11_
    else
      return nil
    end
  else
    return nil
  end
end
local function tmux_navigate(direction)
  if (nil == direction) then
    _G.error("Missing argument direction on fnl/plugin/tmux-nav.fnl:16", 2)
  else
  end
  local notify = autoload("nfnl.notify")
  local socket = get_tmux_socket()
  local pane = tmux_direction(direction)
  local tmux_cmd = {"tmux", "-S", socket, "select-pane", pane}
  local case_16_, case_17_ = vim.fn.system(tmux_cmd)
  if (nil ~= case_16_) then
    local ok = case_16_
    return nil
  elseif ((case_16_ == nil) and (nil ~= case_17_)) then
    local err_msg = case_17_
    return notify.error("[tmux-nav] Could not run `tmux`: ", err_msg)
  else
    return nil
  end
end
local function navigate(direction)
  if (nil == direction) then
    _G.error("Missing argument direction on fnl/plugin/tmux-nav.fnl:25", 2)
  else
  end
  local current_vim_win = vim.fn.winnr()
  vim_navigate(direction)
  if (current_vim_win == vim.fn.winnr()) then
    return tmux_navigate(direction)
  else
    return nil
  end
end
local function setup_default_mapping(in_tmux_3f)
  local core = autoload("nfnl.core")
  local util = autoload("juice.util")
  local nav_keys = {left = "<M-h>", right = "<M-l>", up = "<M-k>", down = "<M-j>"}
  local options = {left = {desc = "jump to the left window", noremap = true, silent = true}, right = {desc = "jump to the right window", noremap = true, silent = true}, up = {desc = "jump to the window above", noremap = true, silent = true}, down = {desc = "jump to the window below", noremap = true, silent = true}}
  local vim_keys = {left = "<C-w>h", right = "<C-w>l", up = "<C-w>k", down = "<C-w>l"}
  local tmux_keys
  local function _21_()
    return navigate("left")
  end
  local function _22_()
    return navigate("right")
  end
  local function _23_()
    return navigate("up")
  end
  local function _24_()
    return navigate("down")
  end
  tmux_keys = {left = _21_, right = _22_, up = _23_, down = _24_}
  local win_nav
  if in_tmux_3f then
    win_nav = tmux_keys
  else
    win_nav = vim_keys
  end
  local make_mapping
  local function _26_(dir)
    if (nil == dir) then
      _G.error("Missing argument dir on fnl/plugin/tmux-nav.fnl:54", 2)
    else
    end
    local mapping
    local function _28_(_241)
      return core.get(_241, dir)
    end
    mapping = core.map(_28_, {nav_keys, win_nav, options})
    table.insert(mapping, 1, "n")
    return mapping
  end
  make_mapping = _26_
  local mappings = core.map(make_mapping, {"left", "right", "up", "down"})
  return util["set-keys"](mappings)
end
return setup_default_mapping(vim.env.TMUX)
