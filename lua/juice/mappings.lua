-- [nfnl] Compiled from fnl/juice/mappings.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = autoload("juice.util")
local nmap = _local_2_["nmap"]
local imap = _local_2_["imap"]
local vmap = _local_2_["vmap"]
local exists_3f = _local_2_["exists?"]
local executable_3f = _local_2_["executable?"]
local _local_3_ = autoload("juice.quickfix")
local toggle_qf_window = _local_3_["toggle-qf-window"]
local toggle_loclist_window = _local_3_["toggle-loclist-window"]
local function setup()
  --[[ "---- GENERAL MAPPINGS ----" ]]
  nmap("Y", "y$", {})
  nmap("<C-l>", ":nohl<cr>", {"noremap"})
  nmap("<leader>;", ":<C-r>\"", {"noremap"})
  nmap("<leader>w", ":w<cr>", {"noremap"})
  nmap("<leader>n", ":registers<cr>", {"noremap"})
  nmap("<F5>", ":make<cr>", {"noremap"})
  --[[ "Vertically center screen when page scrolling up/down" ]]
  nmap("<C-d>", "<C-d>zz", {"noremap", "silent"})
  nmap("<C-u>", "<C-u>zz", {"noremap", "silent"})
  nmap("<C-o>", "<C-o>zz", {"noremap", "silent"})
  nmap("<C-i>", "<C-i>zz", {"noremap", "silent"})
  --[[ "Disable default mappings to train optimal alternatives" ]]
  local function _4_()
    return print("Use C-u or relative jumps instead")
  end
  nmap("{", _4_, {"noremap", "silent"})
  local function _5_()
    return print("Use C-d or relative jumps instead")
  end
  nmap("}", _5_, {"noremap", "silent"})
  --[[ "Map omnifunc" ]]
  imap("<C-t>", "<C-x><C-o>", {"noremap", "silent"})
  --[[ "easier moving of blocks in visual mode" ]]
  vmap("<", "<gv", {"noremap"})
  vmap(">", ">gv", {"noremap"})
  --[[ "add undo step when typing sentences" ]]
  imap("\"", "\"<C-g>u", {"noremap", "silent"})
  imap(".", ".<C-g>u", {"noremap", "silent"})
  imap("!", "!<C-g>u", {"noremap", "silent"})
  imap("?", "?<C-g>u", {"noremap", "silent"})
  imap("(", "(<C-g>u", {"noremap", "silent"})
  imap(")", ")<C-g>u", {"noremap", "silent"})
  imap("{", "{<C-g>u", {"noremap", "silent"})
  imap("}", "}<C-g>u", {"noremap", "silent"})
  imap("[", "[<C-g>u", {"noremap", "silent"})
  imap("]", "]<C-g>u", {"noremap", "silent"})
  --[[ "date shortcuts" ]]
  nmap("<leader>dt", ":.!date '+\\%a, \\%d \\%b \\%Y'<cr>", {"noremap"})
  nmap("<leader>dT", ":.!date '+\\%a, \\%d \\%b \\%Y' --date=", {})
  --[[ "select completion binding item" ]]
  vim.cmd("inoremap <expr> <esc> pumvisible() ? '<C-y><esc>' : '<esc>'")
  --[[ "---- MARK MANAGEMENT ----" ]]
  nmap("<leader>mm", ":marks ARST<cr>", {"noremap"})
  nmap("<leader>mc", ":delmarks ARST<cr>:echo 'Cleared file marks'<cr>", {"noremap"})
  nmap("<leader>a", "`Azz", {"noremap"})
  nmap("<leader>r", "`Rzz", {"noremap"})
  nmap("<leader>s", "`Szz", {"noremap"})
  nmap("<leader>t", "`Tzz", {"noremap"})
  nmap("<leader>ma", "mA:echo 'Marked file A'<cr>", {"noremap"})
  nmap("<leader>mr", "mR:echo 'Marked file R'<cr>", {"noremap"})
  nmap("<leader>ms", "mS:echo 'Marked file S'<cr>", {"noremap"})
  nmap("<leader>mt", "mT:echo 'Marked file T'<cr>", {"noremap"})
  --[[ "---- WINDOW MANAGEMENT ----" ]]
  nmap("<M-h>", "<C-w>h", {"noremap", "silent"})
  nmap("<M-j>", "<C-w>j", {"noremap", "silent"})
  nmap("<M-k>", "<C-w>k", {"noremap", "silent"})
  nmap("<M-l>", "<C-w>l", {"noremap", "silent"})
  nmap("<C-p>", "<C-w>p", {"noremap", "silent"})
  --[[ "---- BUFFER MANAGEMENT ----" ]]
  nmap("<leader>b", ":buffers<cr>:buffer<Space>", {"noremap"})
  nmap("[B", ":bfirst<cr>", {"noremap"})
  nmap("]B", ":blast<cr>", {"noremap"})
  nmap("[b", ":bprevious<cr>", {"noremap"})
  nmap("]b", ":bnext<cr>", {"noremap"})
  nmap("<leader>x", ":bp|bdelete #<cr>", {"noremap"})
  --[[ "---- TAB MANAGEMENT ----" ]]
  nmap("tn", ":tabnew<cr>", {"noremap"})
  nmap("tc", ":tabclose<cr>", {"noremap"})
  nmap("ts", ":tab split<cr>", {"noremap"})
  nmap("[t", ":tabprevious<cr>", {"noremap"})
  nmap("]t", ":tabnext<cr>", {"noremap"})
  nmap("[T", ":tabfirst<cr>", {"noremap"})
  nmap("]T", ":tablast<cr>", {"noremap"})
  --[[ "---- QUICKFIX LIST ----" ]]
  nmap("<leader>c", toggle_qf_window, {"noremap"})
  nmap("[c", ":cprevious<cr>", {"noremap"})
  nmap("]c", ":cnext<cr>", {"noremap"})
  nmap("[C", ":cfirst<cr>", {"noremap"})
  nmap("]C", ":clast<cr>", {"noremap"})
  --[[ "location list" ]]
  nmap("<leader>l", toggle_loclist_window, {"noremap"})
  nmap("[l", ":lprevious<cr>", {"noremap"})
  nmap("]l", ":lnext<cr>", {"noremap"})
  nmap("[L", ":lfirst<cr>", {"noremap"})
  nmap("]L", ":llast<cr>", {"noremap"})
  --[[ "---- SEARCH/REPLACE ----" ]]
  nmap("<leader>/s", ":s//g<left><left>", {"noremap"})
  nmap("<leader>/S", ":%s//g<left><left>", {"noremap"})
  nmap("<leader>/l", ":.,+s//g<left><left><left><left>", {"noremap"})
  nmap("<leader>/w", ":s/\\<<c-r><c-w>\\>//g<left><left>", {"noremap"})
  nmap("<leader>/W", ":%s/\\<<c-r><c-w>\\>//g<left><left>", {"noremap"})
  --[[ "---- EXTERNAL APPS ----" ]]
  --[[ "utilites in tmux split" ]]
  if exists_3f("$TMUX") then
    if executable_3f("lazygit") then
      nmap("<leader>og", ":!tmux neww lazygit<cr><cr>", {"noremap", "silent"})
    else
    end
    if executable_3f("sbtn") then
      nmap("<leader>os", ":!tmux split-window -v -l 30\\% sbtn<cr><cr>", {"noremap", "silent"})
    else
    end
    if executable_3f("scala-cli") then
      nmap("<leader>oc", ":!tmux split-window -v -l 30\\% scala-cli console %<cr><cr>", {"noremap", "silent"})
    else
    end
  else
  end
  --[[ "personal journal" ]]
  if exists_3f("$JOURNAL") then
    local function _10_()
      return vim.cmd((":$tabnew" .. "$JOURNAL/journal.adoc"))
    end
    nmap("<leader>oj", _10_, {"noremap", "silent"})
    local function _11_()
      return vim.cmd((":$tabnew" .. "$JOURNAL/vim/vim.md"))
    end
    nmap("<leader>ov", _11_, {"noremap", "silent"})
  else
  end
  --[[ "---- PLUGINS ----" ]]
  nmap("<leader>L", ":Lazy<cr>", {"noremap", "silent"})
  nmap("<leader>e", ":Oil<cr>", {"noremap", "silent"})
  nmap("<leader>E", ":Oil .<cr>", {"noremap", "silent"})
  nmap("<leader>u", ":UndotreeToggle<cr>", {"noremap", "silent"})
  do
    local builtin = require("telescope.builtin")
    nmap("<leader>f", builtin.find_files, {"noremap", "silent"})
    nmap("<leader>g", builtin.git_files, {"noremap", "silent"})
    nmap("<leader>p", builtin.oldfiles, {"noremap", "silent"})
    nmap("<leader>k", builtin.keymaps, {"noremap", "silent"})
  end
  nmap("<localleader>du", ":DBUIToggle<cr>", {"noremap"})
  nmap("<localleader>d;", ":DB g:db ", {"noremap"})
  nmap("<localleader>dd", ":.DB g:db<cr>", {"noremap"})
  nmap("<localleader>db", ":%DB g:db<cr>", {"noremap"})
  nmap("<localleader>dp", "vip:DB g:db<cr>", {"noremap"})
  do
    local gitsigns = require("gitsigns")
    local function _13_()
      return gitsigns.nav_hunk("next")
    end
    nmap("]h", _13_, {"noremap"})
    local function _14_()
      return gitsigns.nav_hunk("prev")
    end
    nmap("[h", _14_, {"noremap"})
    local function _15_()
      return gitsigns.blame_line({full = true})
    end
    nmap("<localleader>hS", _15_, {"noremap"})
    nmap("<localleader>hp", gitsigns.preview_hunk, {"noremap"})
    nmap("<localleader>hs", gitsigns.stage_hunk, {"noremap"})
    nmap("<localleader>hS", gitsigns.undo_stage_hunk, {"noremap"})
  end
  imap("<C-]>", "<Plug>(copilot-next)")
  return imap("<C-[>", "<Plug>(copilot-prev)")
end
return {setup = setup}
