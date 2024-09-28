-- [nfnl] Compiled from fnl/after/ftplugin/markdown.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local util = autoload("juice.util")
util["assoc-in"](vim.opt, {shiftwidth = 2, tabstop = 2, textwidth = 100, wrap = true, spell = true, spelllang = "en_us"})
local function render_markdown_to_html()
  local tmp_file = vim.fn.system({"mktemp", "--suffix=.html"})
  local current_file = vim.fn.expand("%:p")
  return vim.fn.system("$DOTFILES/pandoc/md-to-html", current_file, tmp_file, "&& ${BROWSER}", tmp_file)
end
local function insert_lines(...)
  local buf = vim.api.nvim_get_current_buf()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local _row = (row - 1)
  return vim.api.nvim_buf_set_lines(buf, _row, (_row + 1), false, {...})
end
local function insert_yaml_metadata()
  local filename = vim.fn.expand("%:t:r")
  local now = vim.fn.strftime("%FT%T%z", vim.fn.localtime())
  return insert_lines("---", "title: ", filename, "created: ", now, "tags: []", "---")
end
local function insert_week()
  local function find_day(dir, day, new_time)
    _G.assert((nil ~= new_time), "Missing argument new-time on /home/rfmejia/.config/nvim/fnl/after/ftplugin/markdown.fnl:30")
    _G.assert((nil ~= day), "Missing argument day on /home/rfmejia/.config/nvim/fnl/after/ftplugin/markdown.fnl:30")
    _G.assert((nil ~= dir), "Missing argument dir on /home/rfmejia/.config/nvim/fnl/after/ftplugin/markdown.fnl:30")
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
  return insert_lines("----", "", text, "")
end
local function insert_day()
  local curr_day = vim.fn.strftime("%a, %d %b %Y")
  local text = ("### " .. curr_day)
  return insert_lines(text, "")
end
local function insert_time()
  local curr_time = vim.fn.strftime("%H:%M")
  local text = ("#### " .. curr_time .. " ")
  return insert_lines(text)
end
local function insert_task()
  return insert_lines("- [ ] ")
end
return util["set-keys"]({{"n", "<localleader>m", insert_yaml_metadata, {desc = "insert metadata as a YAML header", buffer = vim.api.nvim_get_current_buf(), silent = true}}, {"n", "<localleader>v", render_markdown_to_html, {desc = "convert to HTML and show preview in browser", buffer = vim.api.nvim_get_current_buf(), silent = true}}, {"n", "<localleader>w", insert_week, {desc = "insert current week as an h2 header", buffer = vim.api.nvim_get_current_buf(), silent = true}}, {"n", "<localleader>d", insert_day, {desc = "insert current date as an h3 header", buffer = vim.api.nvim_get_current_buf(), silent = true}}, {"n", "<localleader>t", insert_time, {desc = "insert current time as an h4 header", buffer = vim.api.nvim_get_current_buf(), silent = true}}, {"n", "<localleader>x", insert_task, {desc = "insert current time as an h4 header", buffer = vim.api.nvim_get_current_buf(), silent = true}}})
