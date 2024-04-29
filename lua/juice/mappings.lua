-- [nfnl] Compiled from fnl/juice/mappings.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = autoload("juice.util")
local lua_cmd = _local_2_["lua-cmd"]
local nmap = _local_2_["nmap"]
local imap = _local_2_["imap"]
local vmap = _local_2_["vmap"]
local executable_3f = _local_2_["executable?"]
local function setup()
  --[[ "---- GENERAL MAPPINGS ----" ]]
  nmap("Y", "y$", nil, "yank until the end of the line")
  nmap("<C-l>", ":nohl<cr>", {"noremap"}, "clear search highlight")
  nmap("<leader>;", ":<C-r>\"", {"noremap"}, "paste register 0 contents in command mode")
  nmap("<leader>w", ":w<cr>", {"noremap"}, "write buffer")
  nmap("<leader>n", ":registers<cr>", {"noremap"}, "list registers")
  nmap("<F5>", ":make<cr>", {"noremap"}, "trigger `make` in shell")
  do
    nmap("<C-d>", "<C-d>zz", {"noremap", "silent"})
    nmap("<C-u>", "<C-u>zz", {"noremap", "silent"})
    nmap("<C-o>", "<C-o>zz", {"noremap", "silent"})
    nmap("<C-i>", "<C-i>zz", {"noremap", "silent"})
  end
  imap("<C-t>", "<C-x><C-o>", {"noremap", "silent"}, "trigger omnicompletion")
  do
    vmap("<", "<gv", {"noremap"})
    vmap(">", ">gv", {"noremap"})
  end
  do
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
  end
  do
    nmap("<leader>dt", ":.!date '+\\%a, \\%d \\%b \\%Y'<cr>", {"noremap"}, "insert current date")
    nmap("<leader>dT", ":.!date '+\\%a, \\%d \\%b \\%Y' --date=''<left>", nil, "prompt for date query")
  end
  --[[ "select completion binding item" ]]
  vim.cmd("inoremap <expr> <esc> pumvisible() ? '<C-y><esc>' : '<esc>'")
  --[[ "---- MARK MANAGEMENT ----" ]]
  nmap("<leader>mm", ":marks ARST<cr>", {"noremap"}, "list special file marks")
  nmap("<leader>mc", ":delmarks ARST<cr>:echo 'Cleared file marks'<cr>", {"noremap"}, "clear special file marks")
  nmap("<leader>a", "`Azz", {"noremap"}, "jump to A mark")
  nmap("<leader>r", "`Rzz", {"noremap"}, "jump to R mark")
  nmap("<leader>s", "`Szz", {"noremap"}, "jump to S mark")
  nmap("<leader>t", "`Tzz", {"noremap"}, "jump to T mark")
  nmap("<leader>ma", "mA:echo 'Marked file A'<cr>", {"noremap"}, "set A mark")
  nmap("<leader>mr", "mR:echo 'Marked file R'<cr>", {"noremap"}, "set R mark")
  nmap("<leader>ms", "mS:echo 'Marked file S'<cr>", {"noremap"}, "set S mark")
  nmap("<leader>mt", "mT:echo 'Marked file T'<cr>", {"noremap"}, "set T mark")
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
  nmap("<leader>co", ":copen<cr>", {"noremap"}, "open quickfix list")
  nmap("<leader>cc", ":cclose<cr>", {"noremap"}, "close quickfix list")
  nmap("[c", ":cprevious<cr>", {"noremap"}, "jump to previous entry in quickfix list")
  nmap("]c", ":cnext<cr>", {"noremap"}, "jump to previous entry in quickfix list")
  nmap("[C", ":cfirst<cr>", {"noremap"}, "jump to previous entry in quickfix list")
  nmap("]C", ":clast<cr>", {"noremap"}, "jump to previous entry in quickfix list")
  nmap("<leader>lo", ":lopen<cr>", {"noremap"}, "open loclist list")
  nmap("<leader>lc", ":lclose<cr>", {"noremap"}, "close loclist list")
  nmap("[l", ":lprevious<cr>", {"noremap"}, "jump to previous entry in loclist")
  nmap("]l", ":lnext<cr>", {"noremap"}, "jump to next entry in loclist")
  nmap("[L", ":lfirst<cr>", {"noremap"}, "jump to first entry in loclist")
  nmap("]L", ":llast<cr>", {"noremap"}, "jump to last entry in loclist")
  --[[ "---- SEARCH/REPLACE ----" ]]
  nmap("<leader>/s", ":s//g<left><left>", {"noremap"}, "prompt for line search")
  nmap("<leader>/S", ":%s//g<left><left>", {"noremap"}, "prompt for buffer search")
  nmap("<leader>/w", ":s/\\<<c-r><c-w>\\>//g<left><left>", {"noremap"}, "prompt for line search and replace")
  nmap("<leader>/W", ":%s/\\<<c-r><c-w>\\>//g<left><left>", {"noremap"}, "prompt for buffer search and replace")
  nmap("<leader>/v", ":vim // *<left><left><left>", {"noremap"}, "prompt for global search")
  --[[ "---- WINDOW MANAGEMENT ----" ]]
  nmap("<C-p>", "<C-w>p", {"noremap", "silent"}, "jump to previous window")
  if vim.env.TMUX then
    local tmux = autoload("juice.tmux")
    nmap("<M-h>", tmux["navigate-left"], {"noremap", "silent"}, "jump to the nvim/tmux window to the left")
    nmap("<M-l>", tmux["navigate-right"], {"noremap", "silent"}, "jump to the nvim/tmux window to the right")
    nmap("<M-k>", tmux["navigate-up"], {"noremap", "silent"}, "jump to the nvim/tmux window above")
    nmap("<M-j>", tmux["navigate-down"], {"noremap", "silent"}, "jump to the nvim/tmux window below")
  else
    nmap("<M-h>", "<C-w>h", {"noremap", "silent"}, "jump to the window to the left")
    nmap("<M-l>", "<C-w>l", {"noremap", "silent"}, "jump to the window to the right")
    nmap("<M-k>", "<C-w>k", {"noremap", "silent"}, "jump to the window above")
    nmap("<M-j>", "<C-w>j", {"noremap", "silent"}, "jump to the window below")
  end
  --[[ "---- TMUX ----" ]]
  if vim.env.TMUX then
    if executable_3f("lazygit") then
      nmap("<leader>og", ":!tmux neww lazygit<cr><cr>", {"noremap", "silent"}, "open lazygit in a new tmux window")
    else
    end
  else
  end
  --[[ "---- JOURNAL ----" ]]
  if vim.env.JOURNAL then
    local function _6_()
      return vim.cmd((":$tabnew" .. "$JOURNAL/journal.adoc"))
    end
    nmap("<leader>oj", _6_, {"noremap", "silent"}, "open journal in a new tab")
    local function _7_()
      return vim.cmd((":$tabnew" .. "$JOURNAL/vim/vim.adoc"))
    end
    nmap("<leader>ov", _7_, {"noremap", "silent"}, "open vim notes in a new tab")
  else
  end
  --[[ "---- PLUGINS ----" ]]
  nmap("<leader>L", ":Lazy<cr>", {"noremap", "silent"})
  nmap("<leader>e", ":Oil<cr>", {"noremap", "silent"}, "explore files in current file's path")
  nmap("<leader>E", ":Oil .<cr>", {"noremap", "silent"}, "explore files in current working dir")
  nmap("<leader>u", ":UndotreeToggle<cr>", {"noremap", "silent"}, "toggle undotree")
  do
    local builtin = autoload("telescope.builtin")
    nmap("<leader>f", builtin.find_files, {"noremap", "silent"})
    nmap("<leader>g", builtin.git_files, {"noremap", "silent"})
    nmap("<leader>p", builtin.oldfiles, {"noremap", "silent"})
    nmap("<leader>k", builtin.keymaps, {"noremap", "silent"})
  end
  local gitsigns = autoload("gitsigns")
  local function _9_()
    return gitsigns.nav_hunk("next")
  end
  nmap("]g", _9_, {"noremap"}, "jump to next git hunk")
  local function _10_()
    return gitsigns.nav_hunk("prev")
  end
  nmap("[g", _10_, {"noremap"}, "jump to previous git hunk")
  local function _11_()
    return gitsigns.blame_line({full = true})
  end
  nmap("<localleader>gb", _11_, {"noremap"}, "(g)it show line (b)lame")
  nmap("<localleader>gp", gitsigns.preview_hunk, {"noremap"}, "(g)it (p)review hunk")
  nmap("<localleader>gs", gitsigns.stage_hunk, {"noremap"}, "(g)it (s)tage hunk")
  nmap("<localleader>gu", gitsigns.undo_stage_hunk, {"noremap"}, "(g)it (u)ndo staged hunk")
  local function _12_()
    return gitsigns.setloclist()
  end
  nmap("<localleader>gl", _12_, {"noremap"}, "show buffer (g)it hunks in (l)oclist")
  local function _13_()
    return gitsigns.setqflist("all")
  end
  return nmap("<localleader>gc", _13_, {"noremap"}, "show all (g)it hunks in qui(c)kfix list")
end
return {setup = setup}
