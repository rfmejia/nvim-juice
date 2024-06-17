-- [nfnl] Compiled from fnl/juice/mappings.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
local util = autoload("juice.util")
local general = {{"n", "Y", "y$", {desc = "yank until the end of the line"}}, {"n", "<C-l>", ":nohl<cr>", {desc = "clear search highlight", noremap = true}}, {"n", "<leader>;", ":<C-r>\"", {desc = "paste register 0 contents in command mode", noremap = true}}, {"n", "<leader>w", ":w<cr>", {desc = "write buffer", noremap = true}}, {"n", "<leader>n", ":registers<cr>", {desc = "list registers", noremap = true}}, {"n", "<F5>", ":make<cr>", {desc = "trigger `make` in shell", noremap = true}}}
local jumps = {{"n", "<C-d>", "<C-d>zz", {noremap = true, silent = true}}, {"n", "<C-u>", "<C-u>zz", {noremap = true, silent = true}}, {"n", "<C-o>", "<C-o>zz", {noremap = true, silent = true}}, {"n", "<C-i>", "<C-i>zz", {noremap = true, silent = true}}}
local undo_steps = {{"i", "\"", "\"<C-g>u", {noremap = true, silent = true}}, {"i", ".", ".<C-g>u", {noremap = true, silent = true}}, {"i", "!", "!<C-g>u", {noremap = true, silent = true}}, {"i", "?", "?<C-g>u", {noremap = true, silent = true}}, {"i", "(", "(<C-g>u", {noremap = true, silent = true}}, {"i", ")", ")<C-g>u", {noremap = true, silent = true}}, {"i", "{", "{<C-g>u", {noremap = true, silent = true}}, {"i", "}", "}<C-g>u", {noremap = true, silent = true}}, {"i", "[", "[<C-g>u", {noremap = true, silent = true}}, {"i", "]", "]<C-g>u", {noremap = true, silent = true}}}
local dates = {{"n", "<leader>dt", ":.!date '+\\%a, \\%d \\%b \\%Y'<cr>", {desc = "insert current date", noremap = true}}, {"n", "<leader>dT", ":.!date '+\\%a, \\%d \\%b \\%Y' --date=''<left>", {desc = "prompt for date query", noremap = true}}}
local marks = {{"n", "<leader>mm", ":marks ARST<cr>", {noremap = true, desc = "list file marks ARST"}}, {"n", "<leader>mc", ":delmarks ARST<cr>:echo 'Cleared file marks'<cr>", {noremap = true, desc = "clear special file marks"}}, {"n", "<leader>a", "`Azz", {noremap = true, desc = "jump to A mark"}}, {"n", "<leader>r", "`Rzz", {noremap = true, desc = "jump to R mark"}}, {"n", "<leader>s", "`Szz", {noremap = true, desc = "jump to S mark"}}, {"n", "<leader>t", "`Tzz", {noremap = true, desc = "jump to T mark"}}, {"n", "<leader>ma", "mA:echo 'Marked file A'<cr>", {noremap = true, desc = "set A mark"}}, {"n", "<leader>mr", "mR:echo 'Marked file R'<cr>", {noremap = true, desc = "set R mark"}}, {"n", "<leader>ms", "mS:echo 'Marked file S'<cr>", {noremap = true, desc = "set S mark"}}, {"n", "<leader>mt", "mT:echo 'Marked file T'<cr>", {noremap = true, desc = "set T mark"}}}
local buffers = {{"n", "<leader>b", ":buffers<cr>:buffer<Space>", {noremap = true}}, {"n", "[B", ":bfirst<cr>", {noremap = true}}, {"n", "]B", ":blast<cr>", {noremap = true}}, {"n", "[b", ":bprevious<cr>", {noremap = true}}, {"n", "]b", ":bnext<cr>", {noremap = true}}, {"n", "<leader>x", ":bp|bdelete #<cr>", {noremap = true}}}
local tabs = {{"n", "<leader>tn", ":tabnew<cr>", {noremap = true}}, {"n", "<leader>tc", ":tabclose<cr>", {noremap = true}}, {"n", "<leader>ts", ":tab split<cr>", {noremap = true}}, {"n", "[t", ":tabprevious<cr>", {noremap = true}}, {"n", "]t", ":tabnext<cr>", {noremap = true}}, {"n", "[T", ":tabfirst<cr>", {noremap = true}}, {"n", "]T", ":tablast<cr>", {noremap = true}}}
local quickfix = {{"n", "<leader>co", ":copen<cr>", {noremap = true, desc = "open quickfix list"}}, {"n", "<leader>cc", ":cclose<cr>", {noremap = true, desc = "close quickfix list"}}, {"n", "[c", ":cprevious<cr>", {noremap = true, desc = "jump to previous entry in quickfix list"}}, {"n", "]c", ":cnext<cr>", {noremap = true, desc = "jump to previous entry in quickfix list"}}, {"n", "[C", ":cfirst<cr>", {noremap = true, desc = "jump to previous entry in quickfix list"}}, {"n", "]C", ":clast<cr>", {noremap = true, desc = "jump to previous entry in quickfix list"}}, {"n", "<leader>lo", ":lopen<cr>", {noremap = true, desc = "open loclist list"}}, {"n", "<leader>lc", ":lclose<cr>", {noremap = true, desc = "close loclist list"}}, {"n", "[l", ":lprevious<cr>", {noremap = true, desc = "jump to previous entry in loclist"}}, {"n", "]l", ":lnext<cr>", {noremap = true, desc = "jump to next entry in loclist"}}, {"n", "[L", ":lfirst<cr>", {noremap = true, desc = "jump to first entry in loclist"}}, {"n", "]L", ":llast<cr>", {noremap = true, desc = "jump to last entry in loclist"}}}
local search_replace = {{"n", "<leader>/s", ":s//g<left><left>", {noremap = true, desc = "prompt for line search"}}, {"n", "<leader>/S", ":%s//g<left><left>", {noremap = true, desc = "prompt for buffer search"}}, {"n", "<leader>/w", ":s/\\<<c-r><c-w>\\>//g<left><left>", {noremap = true, desc = "prompt for line search and replace"}}, {"n", "<leader>/W", ":%s/\\<<c-r><c-w>\\>//g<left><left>", {noremap = true, desc = "prompt for buffer search and replace"}}, {"n", "<leader>/v", ":vim // *<left><left><left>", {noremap = true, desc = "prompt for global search"}}}
local visual_indent = {{"n", "<", "<gv", {noremap = true}}, {"n", ">", ">gv", {noremap = true}}}
local function setup()
  do
    local mappings = core.concat(general, jumps, undo_steps, dates, marks, buffers, tabs, quickfix, search_replace, visual_indent)
    util["set-keys"](mappings)
  end
  --[[ "select completion binding item" ]]
  vim.cmd("inoremap <expr> <esc> pumvisible() ? '<C-y><esc>' : '<esc>'")
  --[[ "---- TMUX ----" ]]
  if vim.env.TMUX then
    if util["executable?"]("lazygit") then
      vim.keymap.set("n", "<leader>ol", ":!tmux neww lazygit<cr><cr>", {desc = "open lazygit in a new tmux window", noremap = true, silent = true})
    else
    end
  else
  end
  --[[ "---- JOURNAL ----" ]]
  if vim.env.JOURNAL then
    local function _4_()
      return vim.cmd((":$tabnew" .. "$JOURNAL/journal.adoc"))
    end
    local function _5_()
      return vim.cmd((":$tabnew" .. "$JOURNAL/vim/vim.adoc"))
    end
    util["set-keys"]({{"n", "<leader>oj", _4_, {desc = "open journal in a new tab", noremap = true, silent = true}}, {"n", "<leader>ov", _5_, {desc = "open vim notes in a new tab", noremap = true, silent = true}}})
  else
  end
  --[[ "---- PLUGINS ----" ]]
  return util["set-keys"]({{"n", "<leader>L", ":Lazy<cr>", {noremap = true, silent = true}}, {"n", "<leader>u", ":UndotreeToggle<cr>", {desc = "toggle undotree", noremap = true, silent = true}}})
end
local function oil_maps()
  local oil = autoload("oil")
  local function _7_()
    return oil.open()
  end
  return vim.keymap.set("n", "<leader>e", _7_, {desc = "explore files in current file's path", noremap = true, silent = true})
end
local function telescope_maps()
  local builtin = autoload("telescope.builtin")
  local maps = {{"n", "<leader>f", builtin.find_files, {desc = "telescope (f)iles", noremap = true}}, {"n", "<leader>p", builtin.oldfiles, {desc = "telescope oldfiles", noremap = true}}, {"n", "<leader>g", builtin.git_files, {desc = "telescope (g)it files", noremap = true}}, {"n", "<leader>k", builtin.keymaps, {desc = "telescope (k)eymaps", noremap = true}}}
  return util["set-keys"](maps)
end
local function gitsigns_maps()
  local gitsigns = autoload("gitsigns")
  local nav
  local function _8_()
    return gitsigns.nav_hunk("next", {preview = true, wrap = false})
  end
  local function _9_()
    return gitsigns.nav_hunk("prev", {preview = true, wrap = false})
  end
  nav = {{"n", "]g", _8_, {noremap = true, desc = "jump to next git hunk"}}, {"n", "[g", _9_, {noremap = true, desc = "jump to previous git hunk"}}}
  local staging
  local function _10_()
    return gitsigns.stage_hunk({[vim.fn.line(".")] = vim.fn.line("v")})
  end
  local function _11_()
    return gitsigns.reset_hunk({[vim.fn.line(".")] = vim.fn.line("v")})
  end
  staging = {{"n", "<localleader>gs", gitsigns.stage_hunk, {noremap = true, desc = "(g)it (s)tage hunk"}}, {"n", "<localleader>gu", gitsigns.undo_stage_hunk, {noremap = true, desc = "(g)it (u)ndo staged hunk"}}, {"n", "<localleader>gr", gitsigns.reset_hunk, {noremap = true, desc = "(g)it (r)eset hunk"}}, {"n", "<localleader>gS", gitsigns.stage_buffer, {noremap = true, desc = "(g)it (S)tage buffer"}}, {"n", "<localleader>gR", gitsigns.reset_buffer, {noremap = true, desc = "(g)it (R)eset buffer"}}, {"v", "<localleader>gs", _10_, {noremap = true, desc = "(g)it (s)tage hunk"}}, {"v", "<localleader>gr", _11_, {noremap = true, desc = "(g)it (r)eset hunk"}}}
  local blame
  local function _12_()
    return gitsigns.blame_line({full = true})
  end
  blame = {{"n", "<localleader>gb", _12_, {noremap = true, desc = "(g)it show line (b)lame"}}, {"n", "<localleader>gB", gitsigns.toggle_current_line_blame, {noremap = true, desc = "(g)it toggle current line (B)lame"}}}
  local view = {{"n", "<localleader>gp", gitsigns.preview_hunk, {noremap = true, desc = "(g)it (p)review hunk"}}, {"n", "<localleader>gd", gitsigns.diffthis, {noremap = true, desc = "(g)it show (d)iff"}}, {"n", "<localleader>gD", gitsigns.toggle_deleted, {noremap = true, desc = "(g)it toggle (D)eleted hunks"}}}
  local list
  local function _13_()
    return gitsigns.setqflist("all")
  end
  list = {{"n", "<localleader>gl", gitsigns.setloclist, {noremap = true, desc = "show buffer (g)it hunks in (l)oclist"}}, {"n", "<localleader>gc", _13_, {noremap = true, desc = "show all (g)it hunks in qui(c)kfix list"}}}
  local mappings = core.concat(nav, staging, blame, view, list)
  return util["set-keys"](mappings)
end
local function neogit_maps()
  local neogit = autoload("neogit")
  return vim.keymap.set("n", "<leader>og", neogit.open, {desc = "(o)pen (n)eogit", noremap = true})
end
return {setup = setup, ["oil-maps"] = oil_maps, ["telescope-maps"] = telescope_maps, ["gitsigns-maps"] = gitsigns_maps, ["neogit-maps"] = neogit_maps}
