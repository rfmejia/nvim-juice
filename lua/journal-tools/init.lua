-- [nfnl] Compiled from fnl/journal-tools/init.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local notify = autoload("nfnl.notify")
local util = autoload("juice.util")
local function insert_week()
  local function find_day(dir, day, new_time)
    _G.assert((nil ~= new_time), "Missing argument new-time on /home/rfmejia/.config/nvim/fnl/journal-tools/init.fnl:6")
    _G.assert((nil ~= day), "Missing argument day on /home/rfmejia/.config/nvim/fnl/journal-tools/init.fnl:6")
    _G.assert((nil ~= dir), "Missing argument dir on /home/rfmejia/.config/nvim/fnl/journal-tools/init.fnl:6")
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
  local curr_day = vim.fn.strftime("%a, %d %b %Y")
  local text = ("### " .. curr_day)
  return util["insert-lines"](text)
end
local function insert_time()
  local curr_time = vim.fn.strftime("%H:%M")
  local text = ("#### " .. curr_time .. " ")
  return util["insert-lines"](text)
end
local function insert_task()
  return util["insert-lines"]("- [ ] ")
end
local function load_journal_tools()
  local mappings = autoload("juice.mappings")
  mappings["set-journal-maps"]()
  local function _4_()
    return mappings["set-journal-maps"]()
  end
  vim.api.nvim_create_autocmd("FileType", {pattern = "markdown", callback = _4_})
  vim.api.nvim_del_user_command("JournalInit")
  return notify.info("Loaded journal tools")
end
local function setup()
  return vim.api.nvim_create_user_command("JournalInit", load_journal_tools, {desc = "Load default mappings for journal tools"})
end
return {setup = setup, ["insert-week"] = insert_week, ["insert-day"] = insert_day, ["insert-time"] = insert_time, ["insert-task"] = insert_task, ["load-journal-tools"] = load_journal_tools}
