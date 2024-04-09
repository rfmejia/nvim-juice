-- [nfnl] Compiled from fnl/init.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = require("juice.util")
local set_opts = _local_2_["set-opts"]
local auto_setup = _local_2_["auto-setup"]
--[[ "---- LEADER KEYS ----" ]]
vim.g.mapleader = " "
vim.g.maplocalleader = ","
--[[ "---- ----" ]]
auto_setup("juice.plugins")
auto_setup("juice.mappings")
--[[ "---- BEHAVIOR ----" ]]
set_opts({hidden = true, autoread = true, autoindent = true, smartindent = true, shiftwidth = 2, tabstop = 2, softtabstop = 2, expandtab = true, smarttab = true, backspace = "indent,eol,start", history = 10000, ttyfast = true, ttimeoutlen = 50, mouse = "", shortmess = "filnxtToOF", undolevels = 5000, undofile = true, foldenable = false})
--[[ "---- VISUAL ----" ]]
set_opts({number = true, relativenumber = true, signcolumn = "yes:1", cursorline = true, splitbelow = true, splitright = true, linebreak = true, showcmd = true, laststatus = 3, switchbuf = "uselast", wrap = false})
--[[ "---- SEARCH OPTIONS ----" ]]
set_opts({hlsearch = true, incsearch = true, ignorecase = true, smartcase = true, wrapscan = false})
--[[ "---- STATUSLINE ----" ]]
do
  local sl = autoload("juice.statusline")
  vim.opt.statusline = sl["build-statusline"]({})
end
--[[ "---- FILETYPES ----" ]]
vim.cmd("filetype plugin on")
vim.filetype.add({extension = {[{"sbt", "sc"}] = "scala", [{"text", "txt"}] = "text"}, filename = {Jenkinsfile = "groovy", ["tmux.conf"] = "tmux"}})
--[[ "---- COMPLETION ----" ]]
--[[ "remove imports, add spellchecker to completion sources" ]]
vim.opt.complete = ".,w,b,u,t,kspell"
--[[ "-" ]]
vim.opt.completeopt = "menu,menuone,noselect,noinsert"
--[[ "search in current file's directory or pwd (do not use **)" ]]
vim.opt.path = ".,,"
do
  local u = autoload("juice.util")
  if u["has?"]("syntax") then
    vim.cmd("syntax enable")
  else
  end
  if u["has?"]("clipboard") then
    --[[ "Use Linux system clipboard" ]]
    vim.opt.clipboard = "unnamedplus"
  else
  end
  if u["has?"]("wildmenu") then
    --[[ "-" ]]
    vim.opt.wildmenu = true
    --[[ "Set order of completion matches" ]]
    vim.opt.wildmode = "lastused,longest,full"
    --[[ "-" ]]
    vim.opt.wildignore = "*/.git/*,*/.ammonite/*,*/.bloop/*,*/.metals/*,*/node_modules/*,*/build/*,*/target/*,*.class"
    --[[ "ignore case when filtering results" ]]
    vim.opt.wildignorecase = true
    --[[ "use popup to show results" ]]
    vim.opt.wildoptions = "pum"
  else
  end
  --[[ "use ripgrep if available" ]]
  if u["executable?"]("rg") then
    vim.opt.grepprg = "rg\\ --smart-case\\ --hidden\\ --follow\\ --no-heading\\ --vimgrep"
    vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
  else
  end
end
vim.api.nvim_create_user_command("TrimTrailingWhitespaces", ":%s/\\s\\+$", {})
--[[ "---- AUTOCMDS ----" ]]
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
--[[ "Remember the cursor position of the last editing" ]]
autocmd("BufReadPost", {pattern = "*", command = "if line(\"'\\\"\") | exe \"'\\\"\" | endif"})
local function _7_()
  local sl = autoload("juice.statusline")
  sl["git-file-status"]()
  return sl["git-branch"]()
end
autocmd({"BufEnter", "BufWritePost"}, {pattern = "*", callback = _7_})
augroup("highlight-group", {})
--[[ "highlight yanked text" ]]
local function _8_()
  return vim.highlight.on_yank({timeout = 200, on_visual = false})
end
autocmd("TextYankPost", {group = "highlight-group", pattern = "*", callback = _8_})
--[[ "highlight TODO, FIXME and Note: keywords" ]]
autocmd({"WinEnter", "VimEnter"}, {group = "highlight-group", pattern = "*", command = ":silent! call matchadd('Todo','TODO\\|FIXME\\|Note:', -1)"})
local function _9_()
  local c = autoload("juice.colors")
  c["show-extra-whitespace"]()
  return vim.cmd("match ExtraWhitespace /\\s\\+$/")
end
autocmd({"BufWinEnter", "InsertLeave"}, {group = "highlight-group", pattern = "*", callback = _9_})
autocmd({"BufWinLeave", "InsertEnter"}, {group = "highlight-group", pattern = "*", command = "hi clear ExtraWhitespace"})
augroup("terminal-group", {})
--[[ "remove signcolumn in terminal mode" ]]
return autocmd("TermOpen", {group = "terminal-group", pattern = "*", command = "set signcolumn=no"})
