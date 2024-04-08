-- [nfnl] Compiled from fnl/juice/mappings.fnl by https://github.com/Olical/nfnl, do not edit.
local q = require("juice.quickfix")
local u = require("juice.util")
--[[ "---- GENERAL MAPPINGS ----" ]]
u.nmap("Y", "y$", {})
u.nmap("<C-l>", ":nohl<cr>", {"noremap"})
u.nmap("<leader>;", ":<C-r>\"", {"noremap"})
u.nmap("<leader>w", ":w<cr>", {"noremap"})
u.nmap("<leader>n", ":registers<cr>", {"noremap"})
u.nmap("<F5>", ":make<cr>", {"noremap"})
--[[ "Vertically center screen when page scrolling up/down" ]]
u.nmap("<C-d>", "<C-d>zz", {"noremap", "silent"})
u.nmap("<C-u>", "<C-u>zz", {"noremap", "silent"})
u.nmap("<C-o>", "<C-o>zz", {"noremap", "silent"})
u.nmap("<C-i>", "<C-i>zz", {"noremap", "silent"})
--[[ "Disable default mappings to train optimal alternatives" ]]
local function _1_()
  return print("Use C-u or relative jumps instead")
end
u.nmap("{", _1_, {"noremap", "silent"})
local function _2_()
  return print("Use C-d or relative jumps instead")
end
u.nmap("}", _2_, {"noremap", "silent"})
--[[ "Map omnifunc" ]]
u.imap("<C-t>", "<C-x><C-o>", {"noremap", "silent"})
--[[ "easier moving of blocks in visual mode" ]]
u.vmap("<", "<gv", {"noremap"})
u.vmap(">", ">gv", {"noremap"})
--[[ "add undo step when typing sentences" ]]
u.imap("\"", "\"<C-g>u", {"noremap", "silent"})
u.imap(".", ".<C-g>u", {"noremap", "silent"})
u.imap("!", "!<C-g>u", {"noremap", "silent"})
u.imap("?", "?<C-g>u", {"noremap", "silent"})
u.imap("(", "(<C-g>u", {"noremap", "silent"})
u.imap(")", ")<C-g>u", {"noremap", "silent"})
u.imap("{", "{<C-g>u", {"noremap", "silent"})
u.imap("}", "}<C-g>u", {"noremap", "silent"})
u.imap("[", "[<C-g>u", {"noremap", "silent"})
u.imap("]", "]<C-g>u", {"noremap", "silent"})
--[[ "date shortcuts" ]]
u.nmap("<leader>dt", ":.!date '+\\%a, \\%d \\%b \\%Y'<cr>", {"noremap"})
u.nmap("<leader>dT", ":.!date '+\\%a, \\%d \\%b \\%Y' --date=", {})
--[[ "select completion binding item" ]]
vim.cmd("inoremap <expr> <esc> pumvisible() ? '<C-y><esc>' : '<esc>'")
--[[ "---- MARK MANAGEMENT ----" ]]
u.nmap("<leader>mm", ":marks ARST<cr>", {"noremap"})
u.nmap("<leader>mc", ":delmarks ARST<cr>:echo 'Cleared file marks'<cr>", {"noremap"})
u.nmap("<leader>a", "`Azz", {"noremap"})
u.nmap("<leader>r", "`Rzz", {"noremap"})
u.nmap("<leader>s", "`Szz", {"noremap"})
u.nmap("<leader>t", "`Tzz", {"noremap"})
u.nmap("<leader>ma", "mA:echo 'Marked file A'<cr>", {"noremap"})
u.nmap("<leader>mr", "mR:echo 'Marked file R'<cr>", {"noremap"})
u.nmap("<leader>ms", "mS:echo 'Marked file S'<cr>", {"noremap"})
u.nmap("<leader>mt", "mT:echo 'Marked file T'<cr>", {"noremap"})
--[[ "---- WINDOW MANAGEMENT ----" ]]
u.nmap("<M-h>", "<C-w>h", {"noremap", "silent"})
u.nmap("<M-j>", "<C-w>j", {"noremap", "silent"})
u.nmap("<M-k>", "<C-w>k", {"noremap", "silent"})
u.nmap("<M-l>", "<C-w>l", {"noremap", "silent"})
u.nmap("<C-p>", "<C-w>p", {"noremap", "silent"})
--[[ "---- BUFFER MANAGEMENT ----" ]]
u.nmap("<leader>b", ":buffers<cr>:buffer<Space>", {"noremap"})
u.nmap("[B", ":bfirst<cr>", {"noremap"})
u.nmap("]B", ":blast<cr>", {"noremap"})
u.nmap("[b", ":bprevious<cr>", {"noremap"})
u.nmap("]b", ":bnext<cr>", {"noremap"})
u.nmap("<leader>x", ":bp|bdelete #<cr>", {"noremap"})
--[[ "---- TAB MANAGEMENT ----" ]]
u.nmap("tn", ":tabnew<cr>", {"noremap"})
u.nmap("tc", ":tabclose<cr>", {"noremap"})
u.nmap("ts", ":tab split<cr>", {"noremap"})
u.nmap("[t", ":tabprevious<cr>", {"noremap"})
u.nmap("]t", ":tabnext<cr>", {"noremap"})
u.nmap("[T", ":tabfirst<cr>", {"noremap"})
u.nmap("]T", ":tablast<cr>", {"noremap"})
--[[ "---- QUICKFIX LIST ----" ]]
u.nmap("<leader>c", q["toggle-qf-window"], {"noremap"})
u.nmap("[c", ":cprevious<cr>", {"noremap"})
u.nmap("]c", ":cnext<cr>", {"noremap"})
u.nmap("[C", ":cfirst<cr>", {"noremap"})
u.nmap("]C", ":clast<cr>", {"noremap"})
--[[ "location list" ]]
u.nmap("<leader>l", q["toggle-loclist-window"], {"noremap"})
u.nmap("[l", ":lprevious<cr>", {"noremap"})
u.nmap("]l", ":lnext<cr>", {"noremap"})
u.nmap("[L", ":lfirst<cr>", {"noremap"})
u.nmap("]L", ":llast<cr>", {"noremap"})
--[[ "---- SEARCH/REPLACE ----" ]]
u.nmap("<leader>/s", ":s//g<left><left>", {"noremap"})
u.nmap("<leader>/S", ":%s//g<left><left>", {"noremap"})
u.nmap("<leader>/l", ":.,+s//g<left><left><left><left>", {"noremap"})
u.nmap("<leader>/w", ":s/\\<<c-r><c-w>\\>//g<left><left>", {"noremap"})
u.nmap("<leader>/W", ":%s/\\<<c-r><c-w>\\>//g<left><left>", {"noremap"})
--[[ "---- EXTERNAL APPS ----" ]]
--[[ "utilites in tmux split" ]]
if u["exists?"]("$TMUX") then
  if u["executable?"]("lazygit") then
    u.nmap("<leader>og", ":!tmux neww lazygit<cr><cr>", {"noremap", "silent"})
  else
  end
  if u["executable?"]("sbtn") then
    u.nmap("<leader>os", ":!tmux split-window -v -l 30\\% sbtn<cr><cr>", {"noremap", "silent"})
  else
  end
  if u["executable?"]("scala-cli") then
    u.nmap("<leader>oc", ":!tmux split-window -v -l 30\\% scala-cli console %<cr><cr>", {"noremap", "silent"})
  else
  end
else
end
--[[ "personal journal" ]]
if u["exists?"]("$JOURNAL") then
  local function _7_()
    return vim.cmd((":$tabnew" .. "$JOURNAL/journal.adoc"))
  end
  u.nmap("<leader>oj", _7_, {"noremap", "silent"})
  local function _8_()
    return vim.cmd((":$tabnew" .. "$JOURNAL/vim/vim.md"))
  end
  u.nmap("<leader>ov", _8_, {"noremap", "silent"})
else
end
--[[ "---- PLUGINS ----" ]]
u.nmap("<leader>L", ":Lazy<cr>", {"noremap", "silent"})
u.nmap("<leader>e", ":Oil<cr>", {"noremap", "silent"})
u.nmap("<leader>E", ":Oil .<cr>", {"noremap", "silent"})
u.nmap("<leader>u", ":UndotreeToggle<cr>", {"noremap", "silent"})
do
  local builtin = require("telescope.builtin")
  u.nmap("<leader>f", builtin.find_files, {"noremap", "silent"})
  u.nmap("<leader>g", builtin.git_files, {"noremap", "silent"})
  u.nmap("<leader>p", builtin.oldfiles, {"noremap", "silent"})
  u.nmap("<leader>k", builtin.keymaps, {"noremap", "silent"})
end
u.nmap("<localleader>du", ":DBUIToggle<cr>", {"noremap"})
u.nmap("<localleader>d;", ":DB g:db ", {"noremap"})
u.nmap("<localleader>dd", ":.DB g:db<cr>", {"noremap"})
u.nmap("<localleader>db", ":%DB g:db<cr>", {"noremap"})
u.nmap("<localleader>dp", "vip:DB g:db<cr>", {"noremap"})
do
  local gitsigns = require("gitsigns")
  local function _10_()
    return gitsigns.nav_hunk("next")
  end
  u.nmap("]h", _10_, {"noremap"})
  local function _11_()
    return gitsigns.nav_hunk("prev")
  end
  u.nmap("[h", _11_, {"noremap"})
  local function _12_()
    return gitsigns.blame_line({full = true})
  end
  u.nmap("<localleader>hS", _12_, {"noremap"})
  u.nmap("<localleader>hp", gitsigns.preview_hunk, {"noremap"})
  u.nmap("<localleader>hs", gitsigns.stage_hunk, {"noremap"})
  u.nmap("<localleader>hS", gitsigns.undo_stage_hunk, {"noremap"})
end
u.imap("]a", "<Plug>(copilot-next)")
return u.imap("[a", "<Plug>(copilot-prev)")
