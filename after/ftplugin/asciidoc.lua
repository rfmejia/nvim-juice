-- [nfnl] fnl/after/ftplugin/asciidoc.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local core = autoload("nfnl.core")
local notify = autoload("nfnl.notify")
local util = autoload("juice.util")
core["merge!"](vim.opt_local, {shiftwidth = 2, tabstop = 2, textwidth = 80, wrap = true, spell = true, spelllang = "en_us"})
local function insert_lines(text)
  local buf = vim.api.nvim_get_current_buf()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local _row = (row - 1)
  return vim.api.nvim_buf_set_lines(buf, _row, (_row + 1), false, text)
end
local function insert_week()
  local function find_day(dir, day, new_time)
    if (nil == new_time) then
      _G.error("Missing argument new-time on /home/rfmejia/.config/nvim/fnl/after/ftplugin/asciidoc.fnl:21", 2)
    else
    end
    if (nil == day) then
      _G.error("Missing argument day on /home/rfmejia/.config/nvim/fnl/after/ftplugin/asciidoc.fnl:21", 2)
    else
    end
    if (nil == dir) then
      _G.error("Missing argument dir on /home/rfmejia/.config/nvim/fnl/after/ftplugin/asciidoc.fnl:21", 2)
    else
    end
    local new_day = vim.fn.strftime("%a", new_time)
    local secs_in_a_day = (60 * 60 * 24)
    if (day == new_day) then
      return vim.fn.strftime("%b %d", new_time)
    else
      local function _5_()
        if (dir == "fwd") then
          return (new_time + secs_in_a_day)
        else
          return (new_time - secs_in_a_day)
        end
      end
      return find_day(dir, day, _5_())
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
  if (nil == browser_cmd) then
    _G.error("Missing argument browser-cmd on /home/rfmejia/.config/nvim/fnl/after/ftplugin/asciidoc.fnl:50", 2)
  else
  end
  if (nil == out) then
    _G.error("Missing argument out on /home/rfmejia/.config/nvim/fnl/after/ftplugin/asciidoc.fnl:50", 2)
  else
  end
  if (nil == _in) then
    _G.error("Missing argument in on /home/rfmejia/.config/nvim/fnl/after/ftplugin/asciidoc.fnl:50", 2)
  else
  end
  if util["executable?"]("asciidoctor") then
    local case_10_, case_11_ = vim.fn.system({"asciidoctor", "-o", out, _in})
    if (nil ~= case_10_) then
      local ok = case_10_
      return vim.fn.system({browser_cmd, out})
    elseif ((case_10_ == nil) and (nil ~= case_11_)) then
      local err_msg = case_11_
      return notify.error(("[asciidoc] Could not run asciidoctor: " .. err_msg))
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
  local function _14_()
    return preview_in_browser(_in, out, vim.env.BROWSER)
  end
  vim.keymap.set("n", "<localleader>p", _14_, {desc = "convert to HTML and show preview in browser", buffer = true})
else
end
return util["set-keys"]({{"n", "<localleader>w", insert_week, {desc = "insert current week as an h2 header", buffer = true, silent = true}}, {"n", "<localleader>d", ":r!date '+\\%a, \\%d \\%b \\%Y' | xargs -0 printf '\\n== \\%s\\n\\n'<cr>k", {desc = "insert current date as an h2 header", buffer = true, silent = true}}, {"n", "<localleader>t", insert_time, {desc = "insert current time as an h3 header", buffer = true, silent = true}}, {"n", "<localleader>x", insert_task, {desc = "insert asciidoc checkbox", buffer = true, silent = true}}})
