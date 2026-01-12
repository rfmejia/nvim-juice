-- [nfnl] fnl/juice/mappings.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local core = autoload("nfnl.core")
local util = autoload("juice.util")
local general
local function _2_()
  local is_enabled = (vim.opt.number:get() and vim.opt.relativenumber:get())
  return core["merge!"](vim.opt, {number = not is_enabled, relativenumber = not is_enabled})
end
local function _3_()
  local config_path = (vim.env.XDG_CONFIG_HOME .. "/nvim")
  vim.cmd((":$tabnew" .. config_path))
  vim.cmd.tcd(config_path)
  --[[ -?>> (util.call "juice.dotenvrc" "read-path-list") (set vim.opt_local.path) ]]
  return nil
end
general = {{"n", "Y", "y$", {desc = "yank until the end of the line"}}, {"n", "<leader>w", vim.cmd.w, {desc = "write buffer", silent = true}}, {"n", "<leader>r", vim.cmd.registers, {desc = "list registers"}}, {"n", "<F5>", vim.cmd.make, {desc = "trigger `make` in shell"}}, {"n", "<leader>n", _2_, {desc = "toggle number and relativenumber options"}}, {"n", "<leader>on", _3_, {desc = "open nvim config in a new tab", silent = true}}}
local filters
do
  local _repeat
  local function _4_(times, value)
    local acc = ""
    for i = 1, times do
      acc = (acc .. value)
    end
    return acc
  end
  _repeat = _4_
  local vimgrep_cmd = (":vimgrep // **/*" .. _repeat(6, "<left>"))
  local filter_cmd
  local function _5_(cmd)
    return (":filter '' " .. cmd .. _repeat((2 + #cmd), "<left>"))
  end
  filter_cmd = _5_
  filters = {{"n", "<leader>f", ":find ", {desc = "pre-fill find command"}}, {"n", "<leader>v", vimgrep_cmd, {desc = "pre-fill vimgrep command"}}, {"n", "<leader>p", filter_cmd("browse oldfiles"), {desc = "filter and select from oldfiles"}}, {"n", "<leader>k", filter_cmd("map"), {desc = "filter keymaps"}}}
end
local jumps = {{"n", "<C-d>", "<C-d>zz"}, {"n", "<C-u>", "<C-u>zz"}, {"n", "<C-o>", "<C-o>zz"}, {"n", "<C-i>", "<C-i>zz"}, {"n", "'.", "'.zz"}}
local undo_steps = {{"i", "\"", "\"<C-g>u", {silent = true}}, {"i", ".", ".<C-g>u", {silent = true}}, {"i", "!", "!<C-g>u", {silent = true}}, {"i", "?", "?<C-g>u", {silent = true}}, {"i", "(", "(<C-g>u", {silent = true}}, {"i", ")", ")<C-g>u", {silent = true}}, {"i", "{", "{<C-g>u", {silent = true}}, {"i", "}", "}<C-g>u", {silent = true}}, {"i", "[", "[<C-g>u", {silent = true}}, {"i", "]", "]<C-g>u", {silent = true}}}
local dates = {{"n", "<leader>dt", ":.!date '+\\%a, \\%d \\%b \\%Y'<cr>", {desc = "insert current date"}}, {"n", "<leader>dT", ":.!date '+\\%a, \\%d \\%b \\%Y' --date=''<left>", {desc = "prompt for date query"}}}
local quickmarks
do
  local marks = {"A", "S", "D", "F"}
  local create_mark
  local function _6_(key)
    local function _7_()
      vim.cmd.mark(key)
      return vim.notify(string.format("Marked %s", key))
    end
    return {"n", ("m" .. string.lower(key)), _7_, {desc = string.format("[quickmark] set mark for %s", key)}}
  end
  create_mark = _6_
  local jump_to_mark
  local function _8_(key)
    local function _9_()
      local case_10_ = vim.api.nvim_get_mark(key, {})
      if ((_G.type(case_10_) == "table") and true and true and true and (nil ~= case_10_[4])) then
        local _ = case_10_[1]
        local _0 = case_10_[2]
        local _1 = case_10_[3]
        local filename = case_10_[4]
        return vim.cmd.edit(filename)
      else
        return nil
      end
    end
    return {"n", ("'" .. string.lower(key)), _9_, {desc = string.format("[quickmark] jump to %s mark", key)}}
  end
  jump_to_mark = _8_
  local function _12_()
    return vim.cmd.marks(table.concat(marks))
  end
  local function _13_(_241)
    return create_mark(_241)
  end
  local function _14_(_241)
    return jump_to_mark(_241)
  end
  quickmarks = core.concat({{"n", "''", _12_, {desc = string.format("[quickmark] list quickmarks {%s}", table.concat(marks))}}}, core.map(_13_, marks), core.map(_14_, marks))
end
local buffers = {{"n", "<leader>b", ":buffers<cr>:b<Space>"}, {"n", "<leader>x", ":bp|bdelete #<cr>", {silent = true, desc = "[buffer] close buffer"}}}
local tabs = {{"n", "<leader>ts", ":tab split<cr>", {silent = true}}, {"n", "[t", vim.cmd.tabprevious}, {"n", "]t", vim.cmd.tabnext}, {"n", "[T", vim.cmd.tabfirst}, {"n", "]T", vim.cmd.tablast}}
local quickfix = {{"n", "<leader>co", vim.cmd.copen, {desc = "open quickfix list"}}, {"n", "<leader>cc", vim.cmd.cclose, {desc = "close quickfix list"}}, {"n", "[q", vim.cmd.cprevious, {desc = "jump to the previous entry in the current quickfix list"}}, {"n", "]q", vim.cmd.cnext, {desc = "jump to the next entry in the current quickfix list"}}, {"n", "<leader>C", vim.cmd.chistory, {desc = "list quickfix history"}}, {"n", "[C", vim.cmd.colder, {desc = "jump to the previous quickfix list"}}, {"n", "]C", vim.cmd.cnewer, {desc = "jump to the newer quickfix list"}}}
local loclist = {{"n", "<leader>lo", vim.cmd.lopen, {desc = "open loclist list"}}, {"n", "<leader>lc", vim.cmd.lclose, {desc = "close loclist list"}}, {"n", "[l", vim.cmd.lprevious, {desc = "jump to previous entry in the current loclist"}}, {"n", "]l", vim.cmd.lnext, {desc = "jump to next entry in the current loclist"}}, {"n", "<leader>L", vim.cmd.lhistory, {desc = "list loclist history"}}, {"n", "[L", vim.cmd.lolder, {desc = "jump to the previous loclist"}}, {"n", "]L", vim.cmd.lnewer, {desc = "jump to the newer loclist"}}}
local search_replace = {{"n", "<leader>/s", ":s//g<left><left>", {desc = "prompt for line search"}}, {"n", "<leader>/S", ":%s//g<left><left>", {desc = "prompt for buffer search"}}, {"n", "<leader>/w", ":s/\\<<c-r><c-w>\\>//g<left><left>", {desc = "prompt for line search and replace"}}, {"n", "<leader>/W", ":%s/\\<<c-r><c-w>\\>//g<left><left>", {desc = "prompt for buffer search and replace"}}}
local visual_indent = {{"v", "<", "<gv", {}}, {"v", ">", ">gv", {}}}
local terminal_maps
local function _15_()
  return vim.cmd.tabnew("term://bash")
end
local function _16_()
  return vim.cmd.split("term://bash")
end
local function _17_()
  return vim.cmd.vsplit("term://bash")
end
local function _18_()
  vim.cmd.tabnew("term://w3m duckduckgo.com")
  return vim.cmd.startinsert()
end
terminal_maps = {{"t", "<C-o><C-o>", "<C-\\><C-n>"}, {"n", "<leader>otc", _15_}, {"n", "<leader>ots", _16_}, {"n", "<leader>otv", _17_}, {"n", "<leader>ott", ":tabnew term://"}, {"n", "<leader>otd", _18_}}
--[[ "-- OPEN OTHER FILES AND PROGRAMS  --" ]]
local journal_launchers
local function _19_()
  util.call("journal-tools", "setup")
  return vim.cmd((":$tabnew" .. "$JOURNAL/journal.md"))
end
local function _20_()
  autoload("journal-tools")["load-journal-tools"]()
  return vim.cmd((":$tabnew" .. "$JOURNAL/linux/vim.adoc"))
end
journal_launchers = {{"n", "<leader>oj", _19_, {desc = "open journal in a new tab", silent = true}}, {"n", "<leader>ov", _20_, {desc = "open vim notes in a new tab", silent = true}}}
local lazygit_launcher
local _21_
if vim.env.TMUX then
  _21_ = ":!tmux neww lazygit<cr><cr>"
else
  local function _22_()
    vim.cmd.tabnew("term://lazygit")
    return vim.cmd.startinsert()
  end
  _21_ = _22_
end
lazygit_launcher = {{"n", "<leader>og", _21_, {desc = "open lazygit in a new tab or tmux window", silent = true}}}
local opencode_launcher
local _24_
if vim.env.TMUX then
  _24_ = ":!tmux split-window -l 40\\% opencode<cr><cr>"
else
  local function _25_()
    vim.cmd.vsplit("term://opencode")
    return vim.cmd.startinsert()
  end
  _24_ = _25_
end
opencode_launcher = {{"n", "<leader>oc", _24_, {desc = "open opencode in a new tab or tmux window", silent = true}}}
local tmux_apps = {lazydocker = {{"n", "<leader>od", ":!tmux neww lazydocker<cr><cr>", {desc = "open lazydocker in a new tmux window", silent = true}}}}
local function setup()
  local mappings = core.concat(general, filters, jumps, undo_steps, dates, quickmarks, buffers, tabs, quickfix, loclist, search_replace, visual_indent, terminal_maps)
  util["set-keys"](mappings)
  --[[ "select completion binding item" ]]
  vim.cmd("inoremap <expr> <esc> pumvisible() ? '<C-y><esc>' : '<esc>'")
  if util["executable?"]("lazygit") then
    util["set-keys"](lazygit_launcher)
  else
  end
  if util["executable?"]("opencode") then
    util["set-keys"](opencode_launcher)
  else
  end
  if vim.env.JOURNAL then
    util["set-keys"](journal_launchers)
  else
  end
  if vim.env.TMUX then
    for app, maps in pairs(tmux_apps) do
      if util["executable?"](app) then
        util["set-keys"](maps)
      else
      end
    end
    return nil
  else
    return nil
  end
end
return {setup = setup}
