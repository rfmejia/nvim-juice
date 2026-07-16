-- [nfnl] fnl/plugin/journal-tools.fnl
local _let_1_ = require("nfnl.module")
local autoload = _let_1_.autoload
local util = autoload("juice.util")
local opts = {["day-format"] = "%a, %d %b %Y", ["time-format"] = "%H:%M", ["task-format"] = "* [ ] ", maps = nil}
local insert_week
local function _2_()
  local function find_day(dir, day, new_time)
    if (nil == new_time) then
      _G.error("Missing argument new-time on fnl/plugin/journal-tools.fnl:8", 2)
    else
    end
    if (nil == day) then
      _G.error("Missing argument day on fnl/plugin/journal-tools.fnl:8", 2)
    else
    end
    if (nil == dir) then
      _G.error("Missing argument dir on fnl/plugin/journal-tools.fnl:8", 2)
    else
    end
    local new_day = vim.fn.strftime("%a", new_time)
    local secs_in_a_day = (60 * 60 * 24)
    if (day == new_day) then
      return vim.fn.strftime("%b %d", new_time)
    else
      local function _6_()
        if (dir == "fwd") then
          return (new_time + secs_in_a_day)
        else
          return (new_time - secs_in_a_day)
        end
      end
      return find_day(dir, day, _6_())
    end
  end
  local week_num = vim.fn.strftime("%U")
  local week_start = find_day("back", "Mon", vim.fn.localtime())
  local week_end = find_day("fwd", "Sun", vim.fn.localtime())
  local text = ("----" .. "\n\n" .. "## Week " .. week_num .. " (" .. week_start .. " to " .. week_end .. ")" .. "\n\n")
  return vim.api.nvim_paste(text, false, -1)
end
insert_week = _2_
local insert_day
local function _8_()
  local day_format = vim.g.journal_tools["day-format"]
  local curr_day = vim.fn.strftime(day_format)
  local text = ("### " .. curr_day .. "\n\n")
  return vim.api.nvim_paste(text, false, -1)
end
insert_day = _8_
local insert_time
local function _9_()
  local time_format = vim.g.journal_tools["time-format"]
  local curr_time = vim.fn.strftime(time_format)
  local text = ("#### " .. curr_time .. " ")
  vim.api.nvim_paste(text, false, -1)
  return vim.cmd("startinsert!")
end
insert_time = _9_
local insert_task
local function _10_()
  vim.api.nvim_paste(vim.g.journal_tools["task-format"], false, -1)
  return vim.cmd("startinsert!")
end
insert_task = _10_
local keymaps = {{"n", "<localleader>w", insert_week, {desc = "[journal] insert current week as an h2 header", buffer = true, silent = true}}, {"n", "<localleader>d", insert_day, {desc = "[journal] insert current date as an h3 header", buffer = true, silent = true}}, {"n", "<localleader>t", insert_time, {desc = "[journal] insert current time as an h4 header", buffer = true, silent = true}}, {"n", "<localleader>x", insert_task, {desc = "[journal] insert current time as an h4 header", buffer = true, silent = true}}}
vim.g.journal_tools = opts
local function _11_()
  return util["set-keys"](keymaps)
end
return vim.api.nvim_create_autocmd("FileType", {pattern = "markdown", callback = _11_})
