-- [nfnl] Compiled from fnl/juice/quickfix.fnl by https://github.com/Olical/nfnl, do not edit.
local function toggle_window(toggle_qf_3f)
  _G.assert((nil ~= toggle_qf_3f), "Missing argument toggle-qf? on /home/rfmejia/.config/nvim/fnl/juice/quickfix.fnl:1")
  local count_win
  local function _1_()
    return vim.fn.winnr("$")
  end
  count_win = _1_
  local current = count_win()
  local open_cmd
  if toggle_qf_3f then
    open_cmd = "copen"
  else
    open_cmd = "lopen"
  end
  local close_cmd
  if toggle_qf_3f then
    close_cmd = "cclose"
  else
    close_cmd = "lclose"
  end
  vim.cmd(open_cmd)
  if (current == count_win()) then
    return vim.cmd(close_cmd)
  else
    return nil
  end
end
local function toggle_qf_window()
  return toggle_window(true)
end
local function toggle_loclist_window()
  return toggle_window(false)
end
return {["toggle-window"] = toggle_window, ["toggle-qf-window"] = toggle_qf_window, ["toggle-loclist-window"] = toggle_loclist_window}
