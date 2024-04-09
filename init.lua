-- [nfnl] Compiled from fnl/init.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = require("juice.util")
local augroup = _local_2_["augroup"]
local auto_setup = _local_2_["auto-setup"]
local autocmd = _local_2_["autocmd"]
local executable_3f = _local_2_["executable?"]
local set_opts = _local_2_["set-opts"]
local user_command = _local_2_["user-command"]
local _local_3_ = autoload("juice.statusline")
local build_statusline = _local_3_["build-statusline"]
--[[ "---- LEADER KEYS ----" ]]
vim.g.mapleader = " "
vim.g.maplocalleader = ","
--[[ "---- ----" ]]
auto_setup("juice.plugins")
auto_setup("juice.mappings")
--[[ "---- BEHAVIOR ----" ]]
set_opts({clipboard = "unnamedplus", smartindent = true, shiftwidth = 2, tabstop = 2, softtabstop = 2, expandtab = true, mouse = "", shortmess = "filnxtToOF", undolevels = 5000, undofile = true, foldenable = false})
--[[ "---- VISUAL ----" ]]
set_opts({number = true, relativenumber = true, signcolumn = "yes:1", cursorline = true, splitbelow = true, splitright = true, linebreak = true, laststatus = 3, wrap = false})
--[[ "---- SEARCH OPTIONS ----" ]]
set_opts({hlsearch = true, incsearch = true, ignorecase = true, smartcase = true, wrapscan = false})
--[[ "---- STATUSLINE ----" ]]
vim.opt.statusline = build_statusline({})
--[[ "---- FILETYPES ----" ]]
vim.filetype.add({extension = {[{"sbt", "sc"}] = "scala", [{"text", "txt"}] = "text"}, filename = {Jenkinsfile = "groovy", ["tmux.conf"] = "tmux"}})
--[[ "---- COMPLETION ----" ]]
set_opts({complete = ".,w,b,u,t,kspell", completeopt = "menu,menuone,noselect,noinsert", path = ".,,", wildmode = "lastused,longest,full", wildignore = "*/.git/*,*/.ammonite/*,*/.bloop/*,*/.metals/*,*/node_modules/*,*/build/*,*/target/*,*.class", wildignorecase = true, wildoptions = "pum"})
--[[ "use ripgrep if available" ]]
if executable_3f("rg") then
  vim.opt.grepprg = "rg\\ --smart-case\\ --hidden\\ --follow\\ --no-heading\\ --vimgrep"
  vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
else
end
--[[ "---- AUTOCMDS ----" ]]
user_command("TrimTrailingWhitespaces", ":%s/\\s\\+$", {})
--[[ "Remember the cursor position of the last editing" ]]
autocmd("BufReadPost", {pattern = "*", command = "if line(\"'\\\"\") | exe \"'\\\"\" | endif"})
local function _5_()
  local sl = autoload("juice.statusline")
  sl["git-file-status"]()
  return sl["git-branch"]()
end
autocmd({"BufEnter", "BufWritePost"}, {pattern = "*", callback = _5_})
augroup("highlight-group", {})
--[[ "highlight yanked text" ]]
local function _6_()
  return vim.highlight.on_yank({timeout = 200, on_visual = false})
end
autocmd("TextYankPost", {group = "highlight-group", pattern = "*", callback = _6_})
--[[ "highlight TODO, FIXME and Note: keywords" ]]
autocmd({"WinEnter", "VimEnter"}, {group = "highlight-group", pattern = "*", command = ":silent! call matchadd('Todo','TODO\\|FIXME\\|Note:', -1)"})
local function _7_()
  local c = autoload("juice.colors")
  c["show-extra-whitespace"]()
  return vim.cmd("match ExtraWhitespace /\\s\\+$/")
end
autocmd({"BufWinEnter", "InsertLeave"}, {group = "highlight-group", pattern = "*", callback = _7_})
autocmd({"BufWinLeave", "InsertEnter"}, {group = "highlight-group", pattern = "*", command = "hi clear ExtraWhitespace"})
augroup("terminal-group", {})
--[[ "remove signcolumn in terminal mode" ]]
return autocmd("TermOpen", {group = "terminal-group", pattern = "*", command = "set signcolumn=no"})
