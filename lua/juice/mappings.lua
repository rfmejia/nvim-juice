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
      nmap({["<leader>ol"] = {":!tmux neww lazygit<cr><cr>", {"noremap", "silent"}, "open lazygit in a new tmux window"}})
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
  return nmap({["<leader>L"] = {":Lazy<cr>", {"noremap", "silent"}}, ["<leader>u"] = {":UndotreeToggle<cr>", {"noremap", "silent"}, "toggle undotree"}})
end
local function oil_maps()
  local oil = autoload("oil")
  local maps
  local function _9_()
    return oil.open()
  end
  maps = {["<leader>e"] = {_9_, {"noremap", "silent"}, "explore files in current file's path"}}
  return nmap(maps)
end
local function telescope_maps()
  local builtin = autoload("telescope.builtin")
  local maps = {["<leader>f"] = {builtin.find_files, {"noremap", "silent"}, "telescope (f)iles"}, ["<leader>p"] = {builtin.oldfiles, {"noremap", "silent"}, "telescope oldfiles"}, ["<leader>g"] = {builtin.git_files, {"noremap", "silent"}, "telescope (g)it files"}, ["<leader>k"] = {builtin.keymaps, {"noremap", "silent"}, "telescope (k)eymaps"}}
  return nmap(maps)
end
local function gitsigns_maps()
  local gitsigns = autoload("gitsigns")
  local nav_maps
  local function _10_()
    return gitsigns.nav_hunk("next", {preview = true, wrap = false})
  end
  local function _11_()
    return gitsigns.nav_hunk("prev", {preview = true, wrap = false})
  end
  nav_maps = {["]g"] = {_10_, {"noremap"}, "jump to next git hunk"}, ["[g"] = {_11_, {"noremap"}, "jump to previous git hunk"}}
  local action_maps = {["<localleader>gs"] = {gitsigns.stage_hunk, {"noremap"}, "(g)it (s)tage hunk"}, ["<localleader>gu"] = {gitsigns.undo_stage_hunk, {"noremap"}, "(g)it (u)ndo staged hunk"}, ["<localleader>gr"] = {gitsigns.reset_hunk, {"noremap"}, "(g)it (r)eset hunk"}, ["<localleader>gS"] = {gitsigns.stage_buffer, {"noremap"}, "(g)it (S)tage buffer"}, ["<localleader>gR"] = {gitsigns.reset_buffer, {"noremap"}, "(g)it (R)eset buffer"}}
  local visual_action_maps
  local function _12_()
    return gitsigns.stage_hunk({[vim.fn.line(".")] = vim.fn.line("v")})
  end
  local function _13_()
    return gitsigns.reset_hunk({[vim.fn.line(".")] = vim.fn.line("v")})
  end
  visual_action_maps = {["<localleader>gs"] = {_12_, {"noremap"}, "(g)it (s)tage hunk"}, ["<localleader>gr"] = {_13_, {"noremap"}, "(g)it (r)eset hunk"}}
  local blame_maps
  local function _14_()
    return gitsigns.blame_line({full = true})
  end
  blame_maps = {["<localleader>gb"] = {_14_, {"noremap"}, "(g)it show line (b)lame"}, ["<localleader>gB"] = {gitsigns.toggle_current_line_blame, {"noremap"}, "(g)it toggle current line (B)lame"}}
  local view_maps = {["<localleader>gp"] = {gitsigns.preview_hunk, {"noremap"}, "(g)it (p)review hunk"}, ["<localleader>gd"] = {gitsigns.diffthis, {"noremap"}, "(g)it show (d)iff"}, ["<localleader>gD"] = {gitsigns.toggle_deleted, {"noremap"}, "(g)it toggle (D)eleted hunks"}}
  local list_maps
  local function _15_()
    return gitsigns.setloclist()
  end
  local function _16_()
    return gitsigns.setqflist("all")
  end
  list_maps = {["<localleader>gl"] = {_15_, {"noremap"}, "show buffer (g)it hunks in (l)oclist"}, ["<localleader>gc"] = {_16_, {"noremap"}, "show all (g)it hunks in qui(c)kfix list"}}
  for _, mappings in ipairs({nav_maps, action_maps, blame_maps, view_maps, list_maps}) do
    nmap(mappings)
  end
  return vmap(visual_action_maps)
end
local function neogit_maps()
  local neogit = autoload("neogit")
  return nmap({["<leader>og"] = {neogit.open, {"noremap"}, "(o)pen (n)eogit"}})
end
return {setup = setup, ["oil-maps"] = oil_maps, ["telescope-maps"] = telescope_maps, ["gitsigns-maps"] = gitsigns_maps, ["neogit-maps"] = neogit_maps}
