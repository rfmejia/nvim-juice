-- [nfnl] Compiled from fnl/juice/mappings.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = autoload("juice.util")
local lua_cmd = _local_2_["lua-cmd"]
local map_keys = _local_2_["map-keys"]
local nmap = _local_2_["nmap"]
local map = _local_2_["map"]
local imap = _local_2_["imap"]
local vmap = _local_2_["vmap"]
local executable_3f = _local_2_["executable?"]
--[[ (nmap (vim.api.nvim_get_current_buf) ["noremap"] {:<C-l> [":nohl<cr>" "clear search highlight"] :<F5> [":make<cr>" "trigger `make` in shell"] "<leader>;" [":<C-r>\"" "paste register 0 contents in command mode"] :<leader>n [":registers<cr>" "list registers"] :<leader>w [":w<cr>" "write buffer"] :Y ["y$" "yank until the end of the line"]}) ]]
local function setup()
  nmap({Y = {"y$", nil, "yank until the end of the line"}, ["<C-l>"] = {":nohl<cr>", {"noremap"}, "clear search highlight"}, ["<leader>;"] = {":<C-r>\"", {"noremap"}, "paste register 0 contents in command mode"}, ["<leader>w"] = {":w<cr>", {"noremap"}, "write buffer"}, ["<leader>n"] = {":registers<cr>", {"noremap"}, "list registers"}, ["<F5>"] = {":make<cr>", {"noremap"}, "trigger `make` in shell"}})
  nmap({["<C-d>"] = {"<C-d>zz", {"noremap", "silent"}}, ["<C-u>"] = {"<C-u>zz", {"noremap", "silent"}}, ["<C-o>"] = {"<C-o>zz", {"noremap", "silent"}}, ["<C-i>"] = {"<C-i>zz", {"noremap", "silent"}}})
  vmap({["<"] = {"<gv", {"noremap"}}, [">"] = {">gv", {"noremap"}}})
  imap({["\""] = {"\"<C-g>u", {"noremap", "silent"}}, ["."] = {".<C-g>u", {"noremap", "silent"}}, ["!"] = {"!<C-g>u", {"noremap", "silent"}}, ["?"] = {"?<C-g>u", {"noremap", "silent"}}, ["("] = {"(<C-g>u", {"noremap", "silent"}}, [")"] = {")<C-g>u", {"noremap", "silent"}}, ["{"] = {"{<C-g>u", {"noremap", "silent"}}, ["}"] = {"}<C-g>u", {"noremap", "silent"}}, ["["] = {"[<C-g>u", {"noremap", "silent"}}, ["]"] = {"]<C-g>u", {"noremap", "silent"}}})
  nmap({["<leader>dt"] = {":.!date '+\\%a, \\%d \\%b \\%Y'<cr>", {"noremap"}, "insert current date"}, ["<leader>dT"] = {":.!date '+\\%a, \\%d \\%b \\%Y' --date=''<left>", {"noremap"}, "prompt for date query"}})
  --[[ "select completion binding item" ]]
  vim.cmd("inoremap <expr> <esc> pumvisible() ? '<C-y><esc>' : '<esc>'")
  nmap({["<leader>mm"] = {":marks ARST<cr>", {"noremap"}, "list special file marks"}, ["<leader>mc"] = {":delmarks ARST<cr>:echo 'Cleared file marks'<cr>", {"noremap"}, "clear special file marks"}, ["<leader>a"] = {"`Azz", {"noremap"}, "jump to A mark"}, ["<leader>r"] = {"`Rzz", {"noremap"}, "jump to R mark"}, ["<leader>s"] = {"`Szz", {"noremap"}, "jump to S mark"}, ["<leader>t"] = {"`Tzz", {"noremap"}, "jump to T mark"}, ["<leader>ma"] = {"mA:echo 'Marked file A'<cr>", {"noremap"}, "set A mark"}, ["<leader>mr"] = {"mR:echo 'Marked file R'<cr>", {"noremap"}, "set R mark"}, ["<leader>ms"] = {"mS:echo 'Marked file S'<cr>", {"noremap"}, "set S mark"}, ["<leader>mt"] = {"mT:echo 'Marked file T'<cr>", {"noremap"}, "set T mark"}})
  nmap({["<leader>b"] = {":buffers<cr>:buffer<Space>", {"noremap"}}, ["[B"] = {":bfirst<cr>", {"noremap"}}, ["]B"] = {":blast<cr>", {"noremap"}}, ["[b"] = {":bprevious<cr>", {"noremap"}}, ["]b"] = {":bnext<cr>", {"noremap"}}, ["<leader>x"] = {":bp|bdelete #<cr>", {"noremap"}}})
  nmap({["<leader>tn"] = {":tabnew<cr>", {"noremap"}}, ["<leader>tc"] = {":tabclose<cr>", {"noremap"}}, ["<leader>ts"] = {":tab split<cr>", {"noremap"}}, ["[t"] = {":tabprevious<cr>", {"noremap"}}, ["]t"] = {":tabnext<cr>", {"noremap"}}, ["[T"] = {":tabfirst<cr>", {"noremap"}}, ["]T"] = {":tablast<cr>", {"noremap"}}})
  nmap({["<leader>co"] = {":copen<cr>", {"noremap"}, "open quickfix list"}, ["<leader>cc"] = {":cclose<cr>", {"noremap"}, "close quickfix list"}, ["[c"] = {":cprevious<cr>", {"noremap"}, "jump to previous entry in quickfix list"}, ["]c"] = {":cnext<cr>", {"noremap"}, "jump to previous entry in quickfix list"}, ["[C"] = {":cfirst<cr>", {"noremap"}, "jump to previous entry in quickfix list"}, ["]C"] = {":clast<cr>", {"noremap"}, "jump to previous entry in quickfix list"}, ["<leader>lo"] = {":lopen<cr>", {"noremap"}, "open loclist list"}, ["<leader>lc"] = {":lclose<cr>", {"noremap"}, "close loclist list"}, ["[l"] = {":lprevious<cr>", {"noremap"}, "jump to previous entry in loclist"}, ["]l"] = {":lnext<cr>", {"noremap"}, "jump to next entry in loclist"}, ["[L"] = {":lfirst<cr>", {"noremap"}, "jump to first entry in loclist"}, ["]L"] = {":llast<cr>", {"noremap"}, "jump to last entry in loclist"}})
  nmap({["<leader>/s"] = {":s//g<left><left>", {"noremap"}, "prompt for line search"}, ["<leader>/S"] = {":%s//g<left><left>", {"noremap"}, "prompt for buffer search"}, ["<leader>/w"] = {":s/\\<<c-r><c-w>\\>//g<left><left>", {"noremap"}, "prompt for line search and replace"}, ["<leader>/W"] = {":%s/\\<<c-r><c-w>\\>//g<left><left>", {"noremap"}, "prompt for buffer search and replace"}, ["<leader>/v"] = {":vim // *<left><left><left>", {"noremap"}, "prompt for global search"}})
  --[[ "---- WINDOW MANAGEMENT ----" ]]
  nmap({["<C-p>"] = {"<C-w>p", {"noremap", "silent"}, "jump to previous window"}})
  if vim.env.TMUX then
    local tmux = autoload("juice.tmux")
    nmap({["<M-h>"] = {tmux["navigate-left"], {"noremap", "silent"}, "jump to the nvim/tmux window to the left"}, ["<M-l>"] = {tmux["navigate-right"], {"noremap", "silent"}, "jump to the nvim/tmux window to the right"}, ["<M-k>"] = {tmux["navigate-up"], {"noremap", "silent"}, "jump to the nvim/tmux window above"}, ["<M-j>"] = {tmux["navigate-down"], {"noremap", "silent"}, "jump to the nvim/tmux window below"}})
  else
    nmap({["<M-h>"] = {"<C-w>h", {"noremap", "silent"}, "jump to the window to the left"}, ["<M-l>"] = {"<C-w>l", {"noremap", "silent"}, "jump to the window to the right"}, ["<M-k>"] = {"<C-w>k", {"noremap", "silent"}, "jump to the window above"}, ["<M-j>"] = {"<C-w>j", {"noremap", "silent"}, "jump to the window below"}})
  end
  --[[ "---- TMUX ----" ]]
  if vim.env.TMUX then
    if executable_3f("lazygit") then
      nmap({["<leader>og"] = {":!tmux neww lazygit<cr><cr>", {"noremap", "silent"}, "open lazygit in a new tmux window"}})
    else
    end
  else
  end
  --[[ "---- JOURNAL ----" ]]
  if vim.env.JOURNAL then
    local function _6_()
      return vim.cmd((":$tabnew" .. "$JOURNAL/journal.adoc"))
    end
    local function _7_()
      return vim.cmd((":$tabnew" .. "$JOURNAL/vim/vim.adoc"))
    end
    nmap({["<leader>oj"] = {_6_, {"noremap", "silent"}, "open journal in a new tab"}, ["<leader>ov"] = {_7_, {"noremap", "silent"}, "open vim notes in a new tab"}})
  else
  end
  --[[ "---- PLUGINS ----" ]]
  nmap({["<leader>L"] = {":Lazy<cr>", {"noremap", "silent"}}, ["<leader>e"] = {":Oil<cr>", {"noremap", "silent"}, "explore files in current file's path"}, ["<leader>E"] = {":Oil .<cr>", {"noremap", "silent"}, "explore files in current working dir"}, ["<leader>u"] = {":UndotreeToggle<cr>", {"noremap", "silent"}, "toggle undotree"}})
  do
    local builtin = autoload("telescope.builtin")
    nmap({["<leader>f"] = {builtin.find_files, {"noremap", "silent"}, "telescope files"}, ["<leader>g"] = {builtin.git_files, {"noremap", "silent"}, "telescope git files"}, ["<leader>p"] = {builtin.oldfiles, {"noremap", "silent"}, "telescope oldfiles"}, ["<leader>k"] = {builtin.keymaps, {"noremap", "silent"}, "telescope keymaps"}})
  end
  local gitsigns = autoload("gitsigns")
  local function _9_()
    return gitsigns.nav_hunk("next")
  end
  local function _10_()
    return gitsigns.nav_hunk("prev")
  end
  local function _11_()
    return gitsigns.blame_line({full = true})
  end
  local function _12_()
    return gitsigns.setloclist()
  end
  local function _13_()
    return gitsigns.setqflist("all")
  end
  return nmap({["]g"] = {_9_, {"noremap"}, "jump to next git hunk"}, ["[g"] = {_10_, {"noremap"}, "jump to previous git hunk"}, ["<localleader>gb"] = {_11_, {"noremap"}, "(g)it show line (b)lame"}, ["<localleader>gp"] = {gitsigns.preview_hunk, {"noremap"}, "(g)it (p)review hunk"}, ["<localleader>gs"] = {gitsigns.stage_hunk, {"noremap"}, "(g)it (s)tage hunk"}, ["<localleader>gu"] = {gitsigns.undo_stage_hunk, {"noremap"}, "(g)it (u)ndo staged hunk"}, ["<localleader>gl"] = {_12_, {"noremap"}, "show buffer (g)it hunks in (l)oclist"}, ["<localleader>gc"] = {_13_, {"noremap"}, "show all (g)it hunks in qui(c)kfix list"}})
end
return {setup = setup}
