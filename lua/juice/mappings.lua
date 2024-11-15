-- [nfnl] Compiled from fnl/juice/mappings.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
local util = autoload("juice.util")
local general = {{"n", "Y", "y$", {desc = "yank until the end of the line"}}, {"n", "<leader>;", ":<C-r>\"", {desc = "paste register 0 contents in command mode"}}, {"n", "<leader>w", ":w<cr>", {desc = "write buffer", silent = true}}, {"n", "<leader>r", vim.cmd.registers, {desc = "list registers"}}, {"n", "<F2>", "let @+ = getreg('%')", {desc = "copy current file path to clipboard"}}, {"n", "<F5>", vim.cmd.make, {desc = "trigger `make` in shell"}}, {"n", "<leader>ol", ":Lazy<cr>", {desc = "open lazy.nvim", silent = true}}}
local jumps = {{"n", "<C-d>", "<C-d>zz"}, {"n", "<C-u>", "<C-u>zz"}, {"n", "<C-o>", "<C-o>zz"}, {"n", "<C-i>", "<C-i>zz"}}
local undo_steps = {{"i", "\"", "\"<C-g>u", {silent = true}}, {"i", ".", ".<C-g>u", {silent = true}}, {"i", "!", "!<C-g>u", {silent = true}}, {"i", "?", "?<C-g>u", {silent = true}}, {"i", "(", "(<C-g>u", {silent = true}}, {"i", ")", ")<C-g>u", {silent = true}}, {"i", "{", "{<C-g>u", {silent = true}}, {"i", "}", "}<C-g>u", {silent = true}}, {"i", "[", "[<C-g>u", {silent = true}}, {"i", "]", "]<C-g>u", {silent = true}}}
local dates = {{"n", "<leader>dt", ":.!date '+\\%a, \\%d \\%b \\%Y'<cr>", {desc = "insert current date"}}, {"n", "<leader>dT", ":.!date '+\\%a, \\%d \\%b \\%Y' --date=''<left>", {desc = "prompt for date query"}}}
local marks
local function _2_()
  return vim.cmd.marks("ARSTarst")
end
marks = {{"n", "<leader>m", _2_, {desc = "list quick marks (ARST and arst)"}}, {"n", "ma", "ma:echo 'Marked a'<cr>"}, {"n", "mr", "mr:echo 'Marked r'<cr>"}, {"n", "ms", "ms:echo 'Marked s'<cr>"}, {"n", "mt", "mt:echo 'Marked t'<cr>"}, {"n", "mA", "mA:echo 'Marked A'<cr>"}, {"n", "mR", "mR:echo 'Marked R'<cr>"}, {"n", "mS", "mS:echo 'Marked S'<cr>"}, {"n", "mT", "mT:echo 'Marked T'<cr>"}}
local buffers = {{"n", "<leader>b", ":buffers<cr>:buffer<Space>"}, {"n", "[B", vim.cmd.bfirst}, {"n", "]B", vim.cmd.blast}, {"n", "[b", vim.cmd.bprevious}, {"n", "]b", vim.cmd.bnext}, {"n", "<leader>x", ":bp|bdelete #<cr>"}}
local tabs = {{"n", "<leader>tn", vim.cmd.tabnew}, {"n", "<leader>tc", vim.cmd.tabclose}, {"n", "<leader>ts", ":tab split<cr>", {silent = true}}, {"n", "[t", vim.cmd.tabprevious}, {"n", "]t", vim.cmd.tabnext}, {"n", "[T", vim.cmd.tabfirst}, {"n", "]T", vim.cmd.tablast}}
local quickfix = {{"n", "<leader>co", vim.cmd.copen, {desc = "open quickfix list"}}, {"n", "<leader>cc", vim.cmd.cclose, {desc = "close quickfix list"}}, {"n", "[c", vim.cmd.cprevious, {desc = "jump to the previous entry in the current quickfix list"}}, {"n", "]c", vim.cmd.cnext, {desc = "jump to the next entry in the current quickfix list"}}, {"n", "<leader>C", vim.cmd.chistory, {desc = "list quickfix history"}}, {"n", "[C", vim.cmd.colder, {desc = "jump to the previous quickfix list"}}, {"n", "]C", vim.cmd.cnewer, {desc = "jump to the newer quickfix list"}}}
local loclist = {{"n", "<leader>lo", vim.cmd.lopen, {desc = "open loclist list"}}, {"n", "<leader>lc", vim.cmd.lclose, {desc = "close loclist list"}}, {"n", "[l", vim.cmd.lprevious, {desc = "jump to previous entry in the current loclist"}}, {"n", "]l", vim.cmd.lnext, {desc = "jump to next entry in the current loclist"}}, {"n", "<leader>L", vim.cmd.lhistory, {desc = "list loclist history"}}, {"n", "[L", vim.cmd.lolder, {desc = "jump to the previous loclist"}}, {"n", "]L", vim.cmd.lnewer, {desc = "jump to the newer loclist"}}}
local search_replace = {{"n", "<leader>/s", ":s//g<left><left>", {desc = "prompt for line search"}}, {"n", "<leader>/S", ":%s//g<left><left>", {desc = "prompt for buffer search"}}, {"n", "<leader>/w", ":s/\\<<c-r><c-w>\\>//g<left><left>", {desc = "prompt for line search and replace"}}, {"n", "<leader>/W", ":%s/\\<<c-r><c-w>\\>//g<left><left>", {desc = "prompt for buffer search and replace"}}, {"n", "<leader>/v", ":vim // *<left><left><left>", {desc = "prompt for global search"}}}
local visual_indent = {{"v", "<", "<gv", {}}, {"v", ">", ">gv", {}}}
local journal_launchers
local function _3_()
  autoload("journal-tools")["load-journal-tools"]()
  return vim.cmd((":$tabnew" .. "$JOURNAL/journal.md"))
end
local function _4_()
  autoload("journal-tools")["load-journal-tools"]()
  return vim.cmd((":$tabnew" .. "$JOURNAL/linux/vim.adoc"))
end
journal_launchers = {{"n", "<leader>oj", _3_, {desc = "open journal in a new tab", silent = true}}, {"n", "<leader>ov", _4_, {desc = "open vim notes in a new tab", silent = true}}}
local tmux_apps = {lazygit = {{"n", "<leader>og", ":!tmux neww lazygit<cr><cr>", {desc = "open lazygit in a new tmux window", silent = true}}}, lazydocker = {{"n", "<leader>od", ":!tmux neww lazydocker<cr><cr>", {desc = "open lazydocker in a new tmux window", silent = true}}}}
--[[ "-- PLUGIN-SPECIFIC MAPPINGS --" ]]
local oil_maps
local function _5_()
  return util.call("oil", "open")
end
oil_maps = {{"n", "<leader>e", _5_, {desc = "[oil] explore files in current file's path", silent = true}}}
local telescope_maps
local function _6_()
  return util.call("telescope.builtin", "find_files")
end
local function _7_()
  return util.call("telescope.builtin", "oldfiles")
end
local function _8_()
  return util.call("telescope.builtin", "git_files")
end
local function _9_()
  return util.call("telescope.builtin", "keymaps")
end
telescope_maps = {{"n", "<leader>f", _6_, {desc = "[telescope] (f)iles"}}, {"n", "<leader>p", _7_, {desc = "[telescope] oldfiles"}}, {"n", "<leader>g", _8_, {desc = "[telescope] (g)it files"}}, {"n", "<leader>k", _9_, {desc = "[telescope] (k)eymaps"}}}
local gitsigns_maps
do
  local nav
  local function _10_()
    return util.call("gitsigns", "nav_hunk", "next", {preview = true, wrap = false})
  end
  local function _11_()
    return util.call("gitsigns", "nav_hunk", "prev", {preview = true, wrap = false})
  end
  nav = {{"n", "]g", _10_, {desc = "[gitsigns] jump to next git hunk"}}, {"n", "[g", _11_, {desc = "[gitsigns] jump to previous git hunk"}}}
  local staging
  local function _12_()
    return util.call("gitsigns", "stage_hunk")
  end
  local function _13_()
    return util.call("gitsigns", "undo_stage_hunk")
  end
  local function _14_()
    return util.call("gitsigns", "reset_hunk")
  end
  local function _15_()
    return util.call("gitsigns", "stage_buffer")
  end
  local function _16_()
    return util.call("gitsigns", "reset_buffer")
  end
  local function _17_()
    local function _18_()
      return util.call("gitsigns", "stage_hunk", {[vim.fn.line(".")] = vim.fn.line("v")})
    end
    return _18_()
  end
  local function _19_()
    return util.call("gitsigns", "reset_hunk", {[vim.fn.line(".")] = vim.fn.line("v")})
  end
  staging = {{"n", "<localleader>gs", _12_, {desc = "[gitsigns] (g)it (s)tage hunk"}}, {"n", "<localleader>gu", _13_, {desc = "[gitsigns] (g)it (u)ndo staged hunk"}}, {"n", "<localleader>gr", _14_, {desc = "(g)it (r)eset hunk"}}, {"n", "<localleader>gS", _15_, {desc = "[gitsigns] (g)it (S)tage buffer"}}, {"n", "<localleader>gR", _16_, {desc = "[gitsigns] (g)it (R)eset buffer"}}, {"v", "<localleader>gs", _17_, {desc = "[gitsigns] (g)it (s)tage hunk"}}, {"v", "<localleader>gr", _19_, {desc = "[gitsigns] (g)it (r)eset hunk"}}}
  local blame
  local function _20_()
    return util.call("gitsigns", "blame_line", {full = true})
  end
  local function _21_()
    return util.call("gitsigns", "toggle_current_line_blame")
  end
  blame = {{"n", "<localleader>gb", _20_, {desc = "[gitsigns] (g)it show line (b)lame"}}, {"n", "<localleader>gB", _21_, {desc = "[gitsigns] (g)it toggle current line (B)lame"}}}
  local view
  local function _22_()
    return util.call("gitsigns", "preview_hunk")
  end
  local function _23_()
    return util.call("gitsigns", "diffthis")
  end
  local function _24_()
    return util.call("gitsigns", "toggle_deleted")
  end
  view = {{"n", "<localleader>gp", _22_, {desc = "[gitsigns] (g)it (p)review hunk"}}, {"n", "<localleader>gd", _23_, {desc = "[gitsigns] (g)it show (d)iff"}}, {"n", "<localleader>gD", _24_, {desc = "[gitsigns] (g)it toggle (D)eleted hunks"}}}
  local list
  local function _25_()
    return util.call("gitsigns", "setloclist")
  end
  local function _26_()
    return util.call("gitsigns", "setqflist", "all")
  end
  list = {{"n", "<localleader>gl", _25_, {desc = "[gitsigns] show buffer (g)it hunks in (l)oclist"}}, {"n", "<localleader>gc", _26_, {desc = "[gitsigns] show all (g)it hunks in qui(c)kfix list"}}}
  gitsigns_maps = core.concat(nav, staging, blame, view, list)
end
local dadbod_maps = {{"n", "<localleader>d;", ":DB g:db ", {desc = "[dadbod] run an sql statement in command mode", noremap = true, buffer = true}}, {"n", "<localleader>dd", ":.DB g:db<cr>", {desc = "[dadbod] run line as an sql statement", noremap = true, buffer = true}}, {"n", "<localleader>dp", "vip:DB g:db<cr>", {desc = "[dadbod] run paragraph as an sql statement", noremap = true, buffer = true}}, {"n", "<localleader>db", ":%DB g:db<cr>", {desc = "[dadbod] run buffer as sql statements", noremap = true, buffer = true}}}
local journal_maps
local function _27_()
  return util.call("journal-tools", "insert-week")
end
local function _28_()
  return util.call("journal-tools", "insert-day")
end
local function _29_()
  return util.call("journal-tools", "insert-time")
end
local function _30_()
  return util.call("journal-tools", "insert-task")
end
journal_maps = {{"n", "<localleader>w", _27_, {desc = "[journal] insert current week as an h2 header", buffer = true, silent = true}}, {"n", "<localleader>d", _28_, {desc = "[journal] insert current date as an h3 header", buffer = true, silent = true}}, {"n", "<localleader>t", _29_, {desc = "[journal] insert current time as an h4 header", buffer = true, silent = true}}, {"n", "<localleader>x", _30_, {desc = "[journal] insert current time as an h4 header", buffer = true, silent = true}}}
local function setup()
  local mappings = core.concat(general, jumps, undo_steps, dates, marks, buffers, tabs, quickfix, loclist, search_replace, visual_indent)
  util["set-keys"](mappings)
  --[[ "select completion binding item" ]]
  vim.cmd("inoremap <expr> <esc> pumvisible() ? '<C-y><esc>' : '<esc>'")
  if vim.env.TMUX then
    for app, maps in pairs(tmux_apps) do
      if util["executable?"](app) then
        util["set-keys"](maps)
      else
      end
    end
  else
  end
  if vim.env.JOURNAL then
    return util["set-keys"](journal_launchers)
  else
    return nil
  end
end
return {setup = setup, ["oil-maps"] = oil_maps, ["telescope-maps"] = telescope_maps, ["gitsigns-maps"] = gitsigns_maps, ["dadbod-maps"] = dadbod_maps, ["journal-maps"] = journal_maps}
