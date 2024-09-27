-- [nfnl] Compiled from fnl/after/ftplugin/asciidoc.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local util = autoload("juice.util")
util["assoc-in"](vim.opt, {shiftwidth = 2, tabstop = 2, textwidth = 80, wrap = true, spell = true, spelllang = "en_us"})
local function insert_lines(text)
  local buf = vim.api.nvim_get_current_buf()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local _row = (row - 1)
  return vim.api.nvim_buf_set_lines(buf, _row, (_row + 1), false, text)
end
local function insert_week()
  local function find_day(dir, day, new_time)
    _G.assert((nil ~= new_time), "Missing argument new-time on /home/rfmejia/.config/nvim/fnl/after/ftplugin/asciidoc.fnl:19")
    _G.assert((nil ~= day), "Missing argument day on /home/rfmejia/.config/nvim/fnl/after/ftplugin/asciidoc.fnl:19")
    _G.assert((nil ~= dir), "Missing argument dir on /home/rfmejia/.config/nvim/fnl/after/ftplugin/asciidoc.fnl:19")
    local new_day = vim.fn.strftime("%a", new_time)
    local secs_in_a_day = (60 * 60 * 24)
    if (day == new_day) then
      return vim.fn.strftime("%b %d", new_time)
    else
      local function _2_()
        if (dir == "fwd") then
          return (new_time + secs_in_a_day)
        else
          return (new_time - secs_in_a_day)
        end
      end
      return find_day(dir, day, _2_())
    end
  end
  local week_num = vim.fn.strftime("%U")
  local week_start = find_day("back", "Mon", vim.fn.localtime())
  local week_end = find_day("fwd", "Sun", vim.fn.localtime())
  local lines = {"'''", ("= Week " .. week_num .. " (" .. week_start .. " to " .. week_end .. ")"), ""}
  return insert_lines(lines)
end
local function insert_day()
  local curr_day = vim.fn.strftime("%a, %d %b %Y")
  local lines = {("== " .. curr_day), ""}
  return insert_lines(lines)
end
local function insert_time()
  local curr_time = vim.fn.strftime("%H:%M")
  local lines = {("=== " .. curr_time), ""}
  return insert_lines(lines)
end
local function insert_task()
  return insert_lines({"* [ ] "})
end
--[[ (insert-week) ]]
local function preview_in_browser(_in, out, browser_cmd)
  _G.assert((nil ~= browser_cmd), "Missing argument browser-cmd on /home/rfmejia/.config/nvim/fnl/after/ftplugin/asciidoc.fnl:48")
  _G.assert((nil ~= out), "Missing argument out on /home/rfmejia/.config/nvim/fnl/after/ftplugin/asciidoc.fnl:48")
  _G.assert((nil ~= _in), "Missing argument in on /home/rfmejia/.config/nvim/fnl/after/ftplugin/asciidoc.fnl:48")
  if util["executable?"]("asciidoctor") then
    local _4_, _5_ = vim.fn.system({"asciidoctor", "-o", out, _in})
    if (nil ~= _4_) then
      local ok = _4_
      return vim.fn.system({browser_cmd, out})
    elseif ((_4_ == nil) and (nil ~= _5_)) then
      local err_msg = _5_
      return error(("Could not run asciidoctor: " .. err_msg))
    else
      return nil
    end
  else
    return nil
  end
end
if vim.env.BROWSER then
  local _in = vim.fn.expand("%:p")
  local out = "/tmp/preview.html"
  local function _8_()
    return preview_in_browser(_in, out, vim.env.BROWSER)
  end
  vim.keymap.set("n", "<localleader>p", _8_, {desc = "convert to HTML and show preview in browser", buffer = vim.api.nvim_get_current_buf()})
else
end
return util["set-keys"]({{"n", "<localleader>w", insert_week, {desc = "insert current week as an h2 header", buffer = vim.api.nvim_get_current_buf(), silent = true}}, {"n", "<localleader>d", ":r!date '+\\%a, \\%d \\%b \\%Y' | xargs -0 printf '\\n== \\%s\\n\\n'<cr>k", {desc = "insert current date as an h2 header", buffer = vim.api.nvim_get_current_buf(), silent = true}}, {"n", "<localleader>t", insert_time, {desc = "insert current time as an h3 header", buffer = vim.api.nvim_get_current_buf(), silent = true}}, {"n", "<localleader>x", insert_task, {desc = "insert asciidoc checkbox", buffer = vim.api.nvim_get_current_buf(), silent = true}}})
