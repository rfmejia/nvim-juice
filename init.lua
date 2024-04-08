-- [nfnl] Compiled from fnl/init.fnl by https://github.com/Olical/nfnl, do not edit.
--[[ "---- BEHAVIOR ----" ]]
--[[ "Allow switching off unwritten buffers" ]]
vim.opt.hidden = true
--[[ "Detect and read external file changes" ]]
vim.opt.autoread = true
--[[ "Indent new line" ]]
vim.opt.autoindent = true
--[[ "Indent new line in special cases" ]]
vim.opt.smartindent = true
--[[ "Number of spaces for *existing* tabs" ]]
vim.opt.shiftwidth = 2
--[[ "Number of spaces for *inserting* tabs" ]]
vim.opt.tabstop = 2
--[[ "Number of spaces for (auto)indenting, e.g. >> & <<" ]]
vim.opt.softtabstop = 2
--[[ "Convert tabs to spaces" ]]
vim.opt.expandtab = true
--[[ "-" ]]
vim.opt.smarttab = true
--[[ "Disable block folding" ]]
vim.opt.foldenable = false
--[[ "-" ]]
vim.opt.backspace = "indent,eol,start"
--[[ "-" ]]
vim.opt.history = 10000
--[[ "-" ]]
vim.opt.ttyfast = true
--[[ "-" ]]
vim.opt.ttimeoutlen = 50
--[[ "Disable mouse" ]]
vim.opt.mouse = ""
--[[ "-" ]]
vim.opt.shortmess = "filnxtToOF"
--[[ "---- LEADER KEYS ----" ]]
vim.g.mapleader = " "
vim.g.maplocalleader = ","
--[[ "---- VISUAL ----" ]]
--[[ "Show line numbers" ]]
vim.opt.number = true
--[[ "Show numbers relative to current line" ]]
vim.opt.relativenumber = true
--[[ "Display line column" ]]
vim.opt.signcolumn = "yes:1"
--[[ "Highlight cursor position row" ]]
vim.opt.cursorline = true
--[[ "Prefer adding horizontal split below" ]]
vim.opt.splitbelow = true
--[[ "Prefer adding a vertical split on the right" ]]
vim.opt.splitright = true
--[[ "Do not wrap text" ]]
vim.opt.wrap = false
--[[ "When wrapping is turned on, wrap on a line break" ]]
vim.opt.linebreak = true
--[[ "Show queued up command keystrokes" ]]
vim.opt.showcmd = true
--[[ "Show a single status line only" ]]
vim.opt.laststatus = 3
--[[ "Jump to the previously used window when jumping to errors with |quickfix| commands" ]]
vim.opt.switchbuf = "uselast"
--[[ "---- SEARCH OPTIONS ----" ]]
--[[ "Turn on highlight search" ]]
vim.opt.hlsearch = true
--[[ "Search as the query is typed" ]]
vim.opt.incsearch = true
--[[ "Do not wrap search scans" ]]
vim.opt.wrapscan = false
--[[ "Ignore case when using lowercase in search" ]]
vim.opt.ignorecase = true
--[[ "But don't ignore it when using upper case" ]]
vim.opt.smartcase = true
--[[ "---- COMPLETION ----" ]]
--[[ "remove imports, add spellchecker to completion sources" ]]
vim.opt.complete = ".,w,b,u,t,kspell"
--[[ "-" ]]
vim.opt.completeopt = "menu,menuone,noselect,noinsert"
--[[ "search in current file's directory or pwd (do not use **)" ]]
vim.opt.path = ".,,"
--[[ "---- FILETYPES ----" ]]
vim.cmd("filetype plugin on")
vim.filetype.add({extension = {[{"sbt", "sc"}] = "scala", [{"text", "txt"}] = "text"}, filename = {Jenkinsfile = "groovy", ["tmux.conf"] = "tmux"}})
require("juice.plugins")
require("juice.mappings")
require("juice.autocmds")
do
  local u = require("juice.util")
  if u["has?"]("syntax") then
    vim.cmd("syntax enable")
  else
  end
  if u["has?"]("clipboard") then
    --[[ "Use Linux system clipboard" ]]
    vim.opt.clipboard = "unnamedplus"
  else
  end
  if u["has?"]("persistent_undo") then
    --[[ "Increase the number of undos" ]]
    vim.opt.undolevels = 5000
    --[[ "Persist undo logs per file inside `undodir`" ]]
    vim.opt.undofile = true
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
  --[[ "use ripgrep" ]]
  if u["executable?"]("rg") then
    vim.opt.grepprg = "rg\\ --smart-case\\ --hidden\\ --follow\\ --no-heading\\ --vimgrep"
    vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
  else
  end
end
local sl = require("juice.statusline")
vim.opt.statusline = sl["build-statusline"]({})
return nil
