-- [nfnl] Compiled from fnl/journal-tools/init.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
local util = autoload("juice.util")
local default_opts = {["day-format"] = "%a, %d %b %Y", ["time-format"] = "%H:%M", ["task-format"] = "* [ ] ", maps = nil}
local function insert_week()
  local function find_day(dir, day, new_time)
    _G.assert((nil ~= new_time), "Missing argument new-time on /home/rfmejia/.config/nvim/fnl/journal-tools/init.fnl:11")
    _G.assert((nil ~= day), "Missing argument day on /home/rfmejia/.config/nvim/fnl/journal-tools/init.fnl:11")
    _G.assert((nil ~= dir), "Missing argument dir on /home/rfmejia/.config/nvim/fnl/journal-tools/init.fnl:11")
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
  local text = ("## Week " .. week_num .. " (" .. week_start .. " to " .. week_end .. ")")
  return util["insert-lines"]("----", "", text, "")
end
local function insert_day()
  local day_format = vim.g.journal_tools["day-format"]
  local curr_day = vim.fn.strftime(day_format)
  local text = ("### " .. curr_day)
  return util["insert-lines"](text)
end
local function insert_time()
  local time_format = vim.g.journal_tools["time-format"]
  local curr_time = vim.fn.strftime(time_format)
  local text = ("#### " .. curr_time .. " ")
  return util["insert-lines"](text)
end
local function insert_task()
  return util["insert-lines"](vim.g.journal_tools["task-format"])
end
local function load_journal_tools(user_opts)
  local maps
  local _5_
  do
    local t_4_ = user_opts
    if (nil ~= t_4_) then
      t_4_ = t_4_.maps
    else
    end
    _5_ = t_4_
  end
  maps = core.merge(_5_, default_opts.maps)
  local opts = core.merge(default_opts, user_opts)
  opts["maps"] = nil
  util["set-keys"](maps)
  local function _7_()
    return util["set-keys"](maps)
  end
  vim.api.nvim_create_autocmd("FileType", {pattern = "markdown", callback = _7_})
  vim.g.journal_tools = opts
  vim.api.nvim_del_user_command("JournalInit")
  return vim.notify("[journal-tools] Loaded tools")
end
local function setup(opts)
  local function _8_()
    return load_journal_tools(opts)
  end
  return vim.api.nvim_create_user_command("JournalInit", _8_, {desc = "Load default mappings for journal tools"})
end
return {setup = setup, ["insert-week"] = insert_week, ["insert-day"] = insert_day, ["insert-time"] = insert_time, ["insert-task"] = insert_task, ["load-journal-tools"] = load_journal_tools}
