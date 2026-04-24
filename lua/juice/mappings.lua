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
general = {{"n", "Y", "y$", {desc = "yank until the end of the line"}}, {"n", "<leader>w", vim.cmd.w, {desc = "write buffer", silent = true}}, {"n", "<leader>r", vim.cmd.registers, {desc = "list registers"}}, {"i", "<C-space>", "<C-x><C-o>", {desc = "call omnifunc"}}, {"n", "<F5>", vim.cmd.make, {desc = "trigger `make` in shell"}}, {"n", "<leader>n", _2_, {desc = "toggle number and relativenumber options"}}}
local filters
do
  local _repeat
  local function _3_(times, value)
    local acc = ""
    for i = 1, times do
      acc = (acc .. value)
    end
    return acc
  end
  _repeat = _3_
  local vimgrep_cmd = (":vimgrep // **/*" .. _repeat(6, "<left>"))
  local filter_cmd
  local function _4_(cmd)
    return (":filter '' " .. cmd .. _repeat((2 + #cmd), "<left>"))
  end
  filter_cmd = _4_
  filters = {{"n", "<leader>f", ":find ", {desc = "pre-fill find command"}}, {"n", "<leader>v", vimgrep_cmd, {desc = "pre-fill vimgrep command"}}, {"n", "<leader>p", filter_cmd("browse oldfiles"), {desc = "filter and select from oldfiles"}}, {"n", "<leader>k", filter_cmd("map"), {desc = "filter keymaps"}}}
end
local jumps = {{"n", "<C-d>", "<C-d>zz"}, {"n", "<C-u>", "<C-u>zz"}, {"n", "<C-o>", "<C-o>zz"}, {"n", "<C-i>", "<C-i>zz"}, {"n", "'.", "'.zz"}}
local undo_steps = {{"i", "\"", "\"<C-g>u", {silent = true}}, {"i", ".", ".<C-g>u", {silent = true}}, {"i", "!", "!<C-g>u", {silent = true}}, {"i", "?", "?<C-g>u", {silent = true}}, {"i", "(", "(<C-g>u", {silent = true}}, {"i", ")", ")<C-g>u", {silent = true}}, {"i", "{", "{<C-g>u", {silent = true}}, {"i", "}", "}<C-g>u", {silent = true}}, {"i", "[", "[<C-g>u", {silent = true}}, {"i", "]", "]<C-g>u", {silent = true}}}
local dates = {{"n", "<leader>dt", ":.!date '+\\%a, \\%d \\%b \\%Y'<cr>", {desc = "insert current date"}}, {"n", "<leader>dT", ":.!date '+\\%a, \\%d \\%b \\%Y' --date=''<left>", {desc = "prompt for date query"}}}
local quickmarks
do
  local marks = {"A", "S", "D", "F"}
  local create_mark
  local function _5_(key)
    local function _6_()
      vim.cmd.mark(key)
      return vim.notify(string.format("Marked %s", key))
    end
    return {"n", ("m" .. string.lower(key)), _6_, {desc = string.format("[quickmark] set mark for %s", key)}}
  end
  create_mark = _5_
  local jump_to_mark
  local function _7_(key)
    local function _8_()
      local case_9_ = vim.api.nvim_get_mark(key, {})
      if ((_G.type(case_9_) == "table") and true and true and true and (nil ~= case_9_[4])) then
        local _ = case_9_[1]
        local _0 = case_9_[2]
        local _1 = case_9_[3]
        local filename = case_9_[4]
        return vim.cmd.edit(filename)
      else
        return nil
      end
    end
    return {"n", ("'" .. string.lower(key)), _8_, {desc = string.format("[quickmark] jump to %s mark", key)}}
  end
  jump_to_mark = _7_
  local function _11_()
    return vim.cmd.marks(table.concat(marks))
  end
  local function _12_(_241)
    return create_mark(_241)
  end
  local function _13_(_241)
    return jump_to_mark(_241)
  end
  quickmarks = core.concat({{"n", "''", _11_, {desc = string.format("[quickmark] list quickmarks {%s}", table.concat(marks))}}}, core.map(_12_, marks), core.map(_13_, marks))
end
local buffers = {{"n", "<leader>b", ":buffers<cr>:b<Space>"}, {"n", "<leader>x", ":bp|bdelete #<cr>", {silent = true, desc = "[buffer] close buffer"}}}
local tabs = {{"n", "<leader>ts", ":tab split<cr>", {silent = true}}, {"n", "[t", vim.cmd.tabprevious}, {"n", "]t", vim.cmd.tabnext}, {"n", "[T", vim.cmd.tabfirst}, {"n", "]T", vim.cmd.tablast}}
local quickfix = {{"n", "<leader>co", vim.cmd.copen, {desc = "open quickfix list"}}, {"n", "<leader>cc", vim.cmd.cclose, {desc = "close quickfix list"}}, {"n", "[q", vim.cmd.cprevious, {desc = "jump to the previous entry in the current quickfix list"}}, {"n", "]q", vim.cmd.cnext, {desc = "jump to the next entry in the current quickfix list"}}, {"n", "<leader>C", vim.cmd.chistory, {desc = "list quickfix history"}}, {"n", "[C", vim.cmd.colder, {desc = "jump to the previous quickfix list"}}, {"n", "]C", vim.cmd.cnewer, {desc = "jump to the newer quickfix list"}}}
local loclist = {{"n", "<leader>lo", vim.cmd.lopen, {desc = "open loclist list"}}, {"n", "<leader>lc", vim.cmd.lclose, {desc = "close loclist list"}}, {"n", "[l", vim.cmd.lprevious, {desc = "jump to previous entry in the current loclist"}}, {"n", "]l", vim.cmd.lnext, {desc = "jump to next entry in the current loclist"}}, {"n", "<leader>L", vim.cmd.lhistory, {desc = "list loclist history"}}, {"n", "[L", vim.cmd.lolder, {desc = "jump to the previous loclist"}}, {"n", "]L", vim.cmd.lnewer, {desc = "jump to the newer loclist"}}}
local search_replace = {{"n", "<leader>/s", ":s//g<left><left>", {desc = "prompt for line search"}}, {"n", "<leader>/S", ":%s//g<left><left>", {desc = "prompt for buffer search"}}, {"n", "<leader>/w", ":s/\\<<c-r><c-w>\\>//g<left><left>", {desc = "prompt for line search and replace"}}, {"n", "<leader>/W", ":%s/\\<<c-r><c-w>\\>//g<left><left>", {desc = "prompt for buffer search and replace"}}}
local visual_indent = {{"v", "<", "<gv", {}}, {"v", ">", ">gv", {}}}
--[[ "-- OPEN OTHER FILES AND PROGRAMS  --" ]]
local nvim_config_launcher
local function _14_()
  local config_path = (vim.env.XDG_CONFIG_HOME .. "/nvim")
  vim.cmd((":$tabnew" .. config_path))
  vim.cmd.tcd(config_path)
  --[[ -?>> (util.call "juice.dotenvrc" "read-path-list") (set vim.opt_local.path) ]]
  return nil
end
nvim_config_launcher = {{"n", "gon", _14_, {desc = "open nvim config in a new tab", silent = true}}}
local journal_launchers
local function _15_()
  vim.cmd.JournalInit()
  return vim.cmd((":$tabnew" .. "$JOURNAL/journal.md"))
end
local function _16_()
  vim.cmd.JournalInit()
  return vim.cmd((":$tabnew" .. "$JOURNAL/linux/vim.adoc"))
end
journal_launchers = {{"n", "goj", _15_, {desc = "open journal in a new tab", silent = true}}, {"n", "gov", _16_, {desc = "open vim notes in a new tab", silent = true}}}
local mail_draft_launcher
local function _17_()
  local tmp_file = vim.fn.system({"mktemp", "--suffix=.mail"})
  return vim.cmd((":$tabnew" .. tmp_file))
end
mail_draft_launcher = {{"n", "gom", _17_, {desc = "open a new mail draft in new tab"}}}
local lazygit_launcher
local _18_
if vim.env.TMUX then
  _18_ = ":!tmux neww lazygit<cr><cr>"
else
  local function _19_()
    vim.cmd.tabnew("term://lazygit")
    return vim.cmd.startinsert()
  end
  _18_ = _19_
end
lazygit_launcher = {{"n", "gog", _18_, {desc = "open lazygit in a new tab or tmux window", silent = true}}}
local opencode_launcher
local _21_
if vim.env.TMUX then
  _21_ = ":!tmux split-window -l 40\\% opencode<cr><cr>"
else
  local function _22_()
    vim.cmd.vsplit("term://opencode")
    return vim.cmd.startinsert()
  end
  _21_ = _22_
end
opencode_launcher = {{"n", "goc", _21_, {desc = "open opencode in a new tab or tmux window", silent = true}}}
local tmux_apps = {lazydocker = {{"n", "god", ":!tmux neww lazydocker<cr><cr>", {desc = "open lazydocker in a new tmux window", silent = true}}}}
local function setup()
  local map_leaders = {mapleader = " ", maplocalleader = ","}
  local mappings = core.concat(general, filters, jumps, undo_steps, dates, quickmarks, buffers, tabs, quickfix, loclist, search_replace, visual_indent, nvim_config_launcher, mail_draft_launcher)
  core["merge!"](vim.g, map_leaders)
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
