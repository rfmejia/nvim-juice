-- [nfnl] fnl/pack/juice/opt/journal-tools/fnl/journal-tools.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local core = autoload("nfnl.core")
local util = autoload("juice.util")
local default_opts = {["day-format"] = "%a, %d %b %Y", ["time-format"] = "%H:%M", ["task-format"] = "* [ ] ", maps = nil}
local function insert_week()
  local function find_day(dir, day, new_time)
    if (nil == new_time) then
      _G.error("Missing argument new-time on /home/rfmejia/.config/nvim/fnl/pack/juice/opt/journal-tools/fnl/journal-tools.fnl:11", 2)
    else
    end
    if (nil == day) then
      _G.error("Missing argument day on /home/rfmejia/.config/nvim/fnl/pack/juice/opt/journal-tools/fnl/journal-tools.fnl:11", 2)
    else
    end
    if (nil == dir) then
      _G.error("Missing argument dir on /home/rfmejia/.config/nvim/fnl/pack/juice/opt/journal-tools/fnl/journal-tools.fnl:11", 2)
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
  local text = ("----" .. "\n\n" .. "## Week " .. week_num .. " (" .. week_start .. " to " .. week_end .. ")" .. "\n\n")
  return vim.api.nvim_paste(text, false, -1)
end
local function insert_day()
  local day_format = vim.g.journal_tools["day-format"]
  local curr_day = vim.fn.strftime(day_format)
  local text = ("### " .. curr_day .. "\n\n")
  return vim.api.nvim_paste(text, false, -1)
end
local function insert_time()
  local time_format = vim.g.journal_tools["time-format"]
  local curr_time = vim.fn.strftime(time_format)
  local text = ("#### " .. curr_time .. " ")
  vim.api.nvim_paste(text, false, -1)
  return vim.cmd("startinsert!")
end
local function insert_task()
  vim.api.nvim_paste(vim.g.journal_tools["task-format"], false, -1)
  return vim.cmd("startinsert!")
end
local function register_tools(user_opts)
  local maps
  local _8_
  do
    local t_7_ = user_opts
    if (nil ~= t_7_) then
      t_7_ = t_7_.maps
    else
    end
    _8_ = t_7_
  end
  maps = core.merge(_8_, default_opts.maps)
  local opts = core.merge(default_opts, user_opts)
  opts["maps"] = nil
  util["set-keys"](maps)
  local function _10_()
    return util["set-keys"](maps)
  end
  vim.api.nvim_create_autocmd("FileType", {pattern = "markdown", callback = _10_})
  vim.g.journal_tools = opts
  return nil
end
return {["register-tools"] = register_tools, ["insert-week"] = insert_week, ["insert-day"] = insert_day, ["insert-time"] = insert_time, ["insert-task"] = insert_task}
