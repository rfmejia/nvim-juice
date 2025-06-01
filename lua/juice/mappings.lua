-- [nfnl] fnl/juice/mappings.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
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
general = {{"n", "Y", "y$", {desc = "yank until the end of the line"}}, {"n", "<leader>w", vim.cmd.w, {desc = "write buffer", silent = true}}, {"n", "<leader>r", vim.cmd.registers, {desc = "list registers"}}, {"n", "<F2>", "let @+ = getreg('%')", {desc = "copy current file path to clipboard"}}, {"n", "<F5>", vim.cmd.make, {desc = "trigger `make` in shell"}}, {"n", "<leader>n", _2_, {desc = "toggle number and relativenumber options"}}, {"n", "<leader>ol", ":Lazy<cr>", {desc = "open lazy.nvim", silent = true}}, {"n", "<leader>on", _3_, {desc = "open nvim config in a new tab", silent = true}}}
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
local jumps = {{"n", "<C-d>", "<C-d>zz"}, {"n", "<C-u>", "<C-u>zz"}, {"n", "<C-o>", "<C-o>zz"}, {"n", "<C-i>", "<C-i>zz"}}
local undo_steps = {{"i", "\"", "\"<C-g>u", {silent = true}}, {"i", ".", ".<C-g>u", {silent = true}}, {"i", "!", "!<C-g>u", {silent = true}}, {"i", "?", "?<C-g>u", {silent = true}}, {"i", "(", "(<C-g>u", {silent = true}}, {"i", ")", ")<C-g>u", {silent = true}}, {"i", "{", "{<C-g>u", {silent = true}}, {"i", "}", "}<C-g>u", {silent = true}}, {"i", "[", "[<C-g>u", {silent = true}}, {"i", "]", "]<C-g>u", {silent = true}}}
local dates = {{"n", "<leader>dt", ":.!date '+\\%a, \\%d \\%b \\%Y'<cr>", {desc = "insert current date"}}, {"n", "<leader>dT", ":.!date '+\\%a, \\%d \\%b \\%Y' --date=''<left>", {desc = "prompt for date query"}}}
local marks
do
  local marks0 = {"A", "R", "S", "T", "z", "x", "c", "d"}
  local create_mark
  local function _6_(_241)
    return {"n", ("m" .. string.lower(_241)), ("m" .. _241 .. ":echo 'Marked " .. _241 .. "'<cr>")}
  end
  create_mark = _6_
  local jump_to_mark
  local function _7_(_241)
    return {"n", ("'" .. string.lower(_241)), ("`" .. _241)}
  end
  jump_to_mark = _7_
  local function _8_()
    return vim.cmd.marks(table.concat(marks0))
  end
  local function _9_(_241)
    return create_mark(_241)
  end
  local function _10_(_241)
    return jump_to_mark(_241)
  end
  marks = core.concat({{"n", "''", _8_, {desc = "list quick marks (ARST and zxcd)"}}}, core.map(_9_, marks0), core.map(_10_, marks0))
end
local buffers = {{"n", "<leader>b", ":buffers<cr>:buffer<Space>"}, {"n", "<leader>x", ":bp|bdelete #<cr>", {desc = "[buffer] close buffer"}}}
local tabs = {{"n", "<leader>ts", ":tab split<cr>", {silent = true}}, {"n", "[t", vim.cmd.tabprevious}, {"n", "]t", vim.cmd.tabnext}, {"n", "[T", vim.cmd.tabfirst}, {"n", "]T", vim.cmd.tablast}}
local quickfix = {{"n", "<leader>co", vim.cmd.copen, {desc = "open quickfix list"}}, {"n", "<leader>cc", vim.cmd.cclose, {desc = "close quickfix list"}}, {"n", "[q", vim.cmd.cprevious, {desc = "jump to the previous entry in the current quickfix list"}}, {"n", "]q", vim.cmd.cnext, {desc = "jump to the next entry in the current quickfix list"}}, {"n", "<leader>C", vim.cmd.chistory, {desc = "list quickfix history"}}, {"n", "[C", vim.cmd.colder, {desc = "jump to the previous quickfix list"}}, {"n", "]C", vim.cmd.cnewer, {desc = "jump to the newer quickfix list"}}}
local loclist = {{"n", "<leader>lo", vim.cmd.lopen, {desc = "open loclist list"}}, {"n", "<leader>lc", vim.cmd.lclose, {desc = "close loclist list"}}, {"n", "[l", vim.cmd.lprevious, {desc = "jump to previous entry in the current loclist"}}, {"n", "]l", vim.cmd.lnext, {desc = "jump to next entry in the current loclist"}}, {"n", "<leader>L", vim.cmd.lhistory, {desc = "list loclist history"}}, {"n", "[L", vim.cmd.lolder, {desc = "jump to the previous loclist"}}, {"n", "]L", vim.cmd.lnewer, {desc = "jump to the newer loclist"}}}
local search_replace = {{"n", "<leader>/s", ":s//g<left><left>", {desc = "prompt for line search"}}, {"n", "<leader>/S", ":%s//g<left><left>", {desc = "prompt for buffer search"}}, {"n", "<leader>/w", ":s/\\<<c-r><c-w>\\>//g<left><left>", {desc = "prompt for line search and replace"}}, {"n", "<leader>/W", ":%s/\\<<c-r><c-w>\\>//g<left><left>", {desc = "prompt for buffer search and replace"}}, {"n", "<leader>/v", ":vim // *<left><left><left>", {desc = "prompt for global search"}}}
local visual_indent = {{"v", "<", "<gv", {}}, {"v", ">", ">gv", {}}}
local terminal_maps
local function _11_()
  return vim.cmd.tabnew("term://bash")
end
local function _12_()
  return vim.cmd.split("term://bash")
end
local function _13_()
  return vim.cmd.vsplit("term://bash")
end
local function _14_()
  vim.cmd.tabnew("term://w3m duckduckgo.com")
  return vim.cmd.startinsert()
end
terminal_maps = {{"t", "<C-o><C-o>", "<C-\\><C-n>"}, {"n", "<leader>otc", _11_}, {"n", "<leader>ots", _12_}, {"n", "<leader>otv", _13_}, {"n", "<leader>ott", ":tabnew term://"}, {"n", "<leader>otd", _14_}}
--[[ "-- PLUGIN-SPECIFIC MAPPINGS --" ]]
local oil_maps
local function _15_()
  return util.call("oil", "open")
end
oil_maps = {{"n", "<leader>e", _15_, {desc = "[oil] explore files in current file's path", silent = true}}}
local gitsigns_maps
do
  local nav
  local function _16_()
    return util.call("gitsigns", "nav_hunk", "next", {preview = true, wrap = false})
  end
  local function _17_()
    return util.call("gitsigns", "nav_hunk", "prev", {preview = true, wrap = false})
  end
  nav = {{"n", "]g", _16_, {desc = "[gitsigns] jump to next git hunk"}}, {"n", "[g", _17_, {desc = "[gitsigns] jump to previous git hunk"}}}
  local staging
  local function _18_()
    return util.call("gitsigns", "stage_hunk")
  end
  local function _19_()
    return util.call("gitsigns", "reset_hunk")
  end
  local function _20_()
    return util.call("gitsigns", "stage_buffer")
  end
  local function _21_()
    return util.call("gitsigns", "reset_buffer")
  end
  local function _22_()
    local function _23_()
      return util.call("gitsigns", "stage_hunk", {[vim.fn.line(".")] = vim.fn.line("v")})
    end
    return _23_()
  end
  local function _24_()
    return util.call("gitsigns", "reset_hunk", {[vim.fn.line(".")] = vim.fn.line("v")})
  end
  staging = {{"n", "<localleader>gs", _18_, {desc = "[gitsigns] (g)it (s)tage hunk"}}, {"n", "<localleader>gr", _19_, {desc = "(g)it (r)eset hunk"}}, {"n", "<localleader>gS", _20_, {desc = "[gitsigns] (g)it (S)tage buffer"}}, {"n", "<localleader>gR", _21_, {desc = "[gitsigns] (g)it (R)eset buffer"}}, {"v", "<localleader>gs", _22_, {desc = "[gitsigns] (g)it (s)tage hunk"}}, {"v", "<localleader>gr", _24_, {desc = "[gitsigns] (g)it (r)eset hunk"}}}
  local blame
  local function _25_()
    return util.call("gitsigns", "blame_line", {full = true})
  end
  local function _26_()
    return util.call("gitsigns", "toggle_current_line_blame")
  end
  blame = {{"n", "<localleader>gb", _25_, {desc = "[gitsigns] (g)it show line (b)lame"}}, {"n", "<localleader>gB", _26_, {desc = "[gitsigns] (g)it toggle current line (B)lame"}}}
  local view
  local function _27_()
    return util.call("gitsigns", "toggle_signs")
  end
  local function _28_()
    return util.call("gitsigns", "preview_hunk")
  end
  local function _29_()
    return util.call("gitsigns", "preview_hunk_inline")
  end
  local function _30_()
    return util.call("gitsigns", "diffthis")
  end
  view = {{"n", "<localleader>gt", _27_, {desc = "[gitsigns] toggle sign visibility"}}, {"n", "<localleader>gp", _28_, {desc = "[gitsigns] (g)it (p)review hunk"}}, {"n", "<localleader>gi", _29_, {desc = "[gitsigns] (g)it toggle (D)eleted hunks"}}, {"n", "<localleader>gd", _30_, {desc = "[gitsigns] (g)it show (d)iff"}}}
  local list
  local function _31_()
    return util.call("gitsigns", "setloclist")
  end
  local function _32_()
    return util.call("gitsigns", "setqflist", "all")
  end
  list = {{"n", "<localleader>gl", _31_, {desc = "[gitsigns] show buffer (g)it hunks in (l)oclist"}}, {"n", "<localleader>gc", _32_, {desc = "[gitsigns] show all (g)it hunks in qui(c)kfix list"}}}
  gitsigns_maps = core.concat(nav, staging, blame, view, list)
end
local copilot_maps = {{"i", "<C-j>", "<Plug>(copilot-next)", {desc = "[copilot] next suggestion"}}, {"i", "<C-k>", "<Plug>(copilot-previous)", {desc = "[copilot] previous suggestion"}}, {"i", "<C-l>", "<Plug>(copilot-accept-word)", {desc = "[copilot] accept word suggestion"}}, {"i", "<C-h>", "<Plug>(copilot-dismiss)", {desc = "[copilot] dismiss suggestion"}}}
local dadbod_maps = {{"n", "<localleader>d;", ":DB g:db ", {desc = "[dadbod] run an sql statement in command mode", noremap = true, buffer = true}}, {"n", "<localleader>dd", ":.DB g:db<cr>", {desc = "[dadbod] run line as an sql statement", noremap = true, buffer = true}}, {"n", "<localleader>dp", "vip:DB g:db<cr>", {desc = "[dadbod] run paragraph as an sql statement", noremap = true, buffer = true}}, {"n", "<localleader>db", ":%DB g:db<cr>", {desc = "[dadbod] run buffer as sql statements", noremap = true, buffer = true}}}
local journal_maps
local function _33_()
  return util.call("journal-tools", "insert-week")
end
local function _34_()
  return util.call("journal-tools", "insert-day")
end
local function _35_()
  return util.call("journal-tools", "insert-time")
end
local function _36_()
  return util.call("journal-tools", "insert-task")
end
journal_maps = {{"n", "<localleader>w", _33_, {desc = "[journal] insert current week as an h2 header", buffer = true, silent = true}}, {"n", "<localleader>d", _34_, {desc = "[journal] insert current date as an h3 header", buffer = true, silent = true}}, {"n", "<localleader>t", _35_, {desc = "[journal] insert current time as an h4 header", buffer = true, silent = true}}, {"n", "<localleader>x", _36_, {desc = "[journal] insert current time as an h4 header", buffer = true, silent = true}}}
--[[ "-- OPEN OTHER FILES AND PROGRAMS  --" ]]
local journal_launchers
local function _37_()
  util.call("journal-tools", "setup")
  return vim.cmd((":$tabnew" .. "$JOURNAL/journal.md"))
end
local function _38_()
  autoload("journal-tools")["load-journal-tools"]()
  return vim.cmd((":$tabnew" .. "$JOURNAL/linux/vim.adoc"))
end
journal_launchers = {{"n", "<leader>oj", _37_, {desc = "open journal in a new tab", silent = true}}, {"n", "<leader>ov", _38_, {desc = "open vim notes in a new tab", silent = true}}}
local lazygit_launcher
local _39_
if vim.env.TMUX then
  _39_ = ":!tmux neww lazygit<cr><cr>"
else
  local function _40_()
    vim.cmd.tabnew("term://lazygit")
    return vim.cmd.startinsert()
  end
  _39_ = _40_
end
lazygit_launcher = {{"n", "<leader>og", _39_, {desc = "open lazygit in a new tab or tmux window", silent = true}}}
local tmux_apps = {lazydocker = {{"n", "<leader>od", ":!tmux neww lazydocker<cr><cr>", {desc = "open lazydocker in a new tmux window", silent = true}}}}
local function setup()
  local mappings = core.concat(general, filters, jumps, undo_steps, dates, marks, buffers, tabs, quickfix, loclist, search_replace, visual_indent, terminal_maps)
  util["set-keys"](mappings)
  --[[ "select completion binding item" ]]
  vim.cmd("inoremap <expr> <esc> pumvisible() ? '<C-y><esc>' : '<esc>'")
  if util["executable?"]("lazygit") then
    util["set-keys"](lazygit_launcher)
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
return {setup = setup, ["oil-maps"] = oil_maps, ["gitsigns-maps"] = gitsigns_maps, ["copilot-maps"] = copilot_maps, ["dadbod-maps"] = dadbod_maps, ["journal-maps"] = journal_maps}
